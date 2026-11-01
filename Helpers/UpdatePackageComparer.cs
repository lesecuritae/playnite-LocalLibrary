using System;
using System.Collections.Generic;

namespace LocalLibrary.Helpers
{
    public sealed class UpdatePackage
    {
        public string Path { get; set; }
        public string TargetVersion { get; set; }
        public DateTime? PublishedAtUtc { get; set; }
    }

    // Orders explicit metadata only; it does not establish patch compatibility.
    public sealed class UpdatePackageComparer : IComparer<UpdatePackage>
    {
        public int Compare(UpdatePackage a, UpdatePackage b)
        {
            if (ReferenceEquals(a, b)) return 0;
            if (a == null) return 1;
            if (b == null) return -1;

            string[] av = Parse(a.TargetVersion);
            string[] bv = Parse(b.TargetVersion);
            if (av != null && bv == null) return -1;
            if (av == null && bv != null) return 1;
            if (av != null)
            {
                int versionOrder = CompareParts(av, bv);
                if (versionOrder != 0) return versionOrder;
            }

            if (a.PublishedAtUtc.HasValue != b.PublishedAtUtc.HasValue)
                return a.PublishedAtUtc.HasValue ? -1 : 1;
            if (a.PublishedAtUtc.HasValue)
            {
                int dateOrder = a.PublishedAtUtc.Value.CompareTo(b.PublishedAtUtc.Value);
                if (dateOrder != 0) return dateOrder;
            }

            string ap = a.Path ?? string.Empty;
            string bp = b.Path ?? string.Empty;
            int pathOrder = StringComparer.OrdinalIgnoreCase.Compare(ap, bp);
            return pathOrder != 0 ? pathOrder : StringComparer.Ordinal.Compare(ap, bp);
        }

        private static string[] Parse(string text)
        {
            if (text == null) return null;
            text = text.Trim();
            if (text.Length > 0 && (text[0] == 'v' || text[0] == 'V'))
                text = text.Substring(1);
            if (text.Length == 0) return null;
            string[] parts = text.Split('.');
            for (int i = 0; i < parts.Length; i++)
            {
                string part = parts[i];
                if (part.Length == 0) return null;
                for (int j = 0; j < part.Length; j++)
                    if (part[j] < '0' || part[j] > '9') return null;
                int start = 0;
                while (start < part.Length - 1 && part[start] == '0') start++;
                parts[i] = part.Substring(start);
            }
            return parts;
        }

        private static int CompareParts(string[] a, string[] b)
        {
            for (int i = 0; i < Math.Max(a.Length, b.Length); i++)
            {
                string ac = i < a.Length ? a[i] : "0";
                string bc = i < b.Length ? b[i] : "0";
                int order = ac.Length.CompareTo(bc.Length);
                if (order == 0) order = StringComparer.Ordinal.Compare(ac, bc);
                if (order != 0) return order;
            }
            return 0;
        }
    }
}
