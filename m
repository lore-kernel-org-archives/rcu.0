Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32CDF17C8;
	Sat,  8 Jun 2024 01:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717810843; cv=none; b=UEupebATEXMHs2AHcRLdbngUr/L/hQ6vs91vVRY0VSpQHSUK9JGpj7u5JUmu2wqHjpUVRs2Q24BHNUEK/vAXfxrdKoaPoAureg/MO2wY+tXTHSFVglO1s9vEu6+ZYdoV1QfE67n2mFQxCXcGH9htm8fHMbAElSyXNvkfDin33Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717810843; c=relaxed/simple;
	bh=RbTPg4S/ysm54UTzBHh/+YK6rrBNdPkV6bmNQeYbX1c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=AMN6dq/nA+jIII7JU1ERf2KF7iKq2kUvl4NochLCMOVgwiwn/plapuyAoqlrn+EcvFxxKQad4qhyIlhM10Uww2en1yRVLH5ufbY5QEkuA+Yh+8IMVAbrsxHZVej20Z5wIdQjqilpWwOFuiqNyxc7uhsr6VHymN9YjlGUAzs/7ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FptiezBC; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FptiezBC"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1f68834bfdfso20972715ad.3;
        Fri, 07 Jun 2024 18:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717810841; x=1718415641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TtWpCftc1i0dh9TufBQnUO/VJ3Tz4vjLVpf1e9btJYA=;
        b=FptiezBCaSQ+1EZsJW1chL5xrlgZS9OxvlpaX89a/x1Wvpz0mkFHSfW+QGggF5chUK
         Sjool+5rO1ZmXoQRKNcqXSqlHjPTqgyYIeonkYca7fzh8yzOGqG6lszsU3jlDLRr9scM
         UqINHh9B3rUP+ShP86FtLOKNj1iRhJD5N5DEVbgvRZktQrJHj4TbVpLnB+RELty/avXM
         RSXqxpJJqwHEON3fA8DJchcnGRldkZ8YiK7z4e4ECXp94gXdmC5iVbAUU4RmDqMCnDlJ
         FIry79Xps2rtnzM4znWsdjuRXTzfM4IoWmg2e4YJ7hSPSjBDdgxfYBVpx1AL7efFfdTQ
         NkhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717810841; x=1718415641;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TtWpCftc1i0dh9TufBQnUO/VJ3Tz4vjLVpf1e9btJYA=;
        b=SGzNumIsfxuGX0loMBxaMrtNPiPuzP8lDJoze38Wgn22GKozEj04g7Tm3dFvgLE4CR
         oWZW5WUrht+4wDyJeJw4K0qF6F0mR9WrLLPZ7nAaXTdDt0cTkyJnKETIS/g6UWu8WZtU
         WGoZY4wdwVMyoi/jabP2uybb2aGoYQUzcddqDyeKwye18LrddzBfS6KeAl9MZNoSLXuN
         22Ne4JEnxXCqIPs1RaRMmUIiSQYMUBKj/Gx7tbirurXfAp8KZxHS58R34dCtUZz586aG
         XshJGbOs1HVeIkgbaWBbqIRZuABCxogDE84VJ7lfko3a+2kuRK8OcdDnFytzCojxkIbz
         rT5g==
X-Forwarded-Encrypted: i=1; AJvYcCWsB1SVo/c6CsDpexrH+OT0QGf+oppzWlH2Eyli+CEu0oY0Sw3bbQcO+Zxlnv5ZLln9E0HsmgHkzZhvjl6AO0CDtfkATlzoVlO9NUOh4kpiQX6BtVrkLVi6R9V9WfHrTABv
X-Gm-Message-State: AOJu0YzmJkmNMMwSJv0rHe53gifgYhHMNs/I/jG58D5HbkwOP8xaJWAp
	N7IPn+9BrsjXQTR2qtejs25ZdBoLqNKWI7LWYhldoRt4jy4D3/8b
X-Google-Smtp-Source: AGHT+IEb5JRSiY87d55ZsQCCHAOEce4xJO4WGdSBSAWZ4GEVElX1/RvtUBEND13XIf0x1UR/goYTdQ==
X-Received: by 2002:a17:903:41cd:b0:1f4:5c4b:dc48 with SMTP id d9443c01a7336-1f6d02d1ff5mr48612475ad.11.1717810841204;
        Fri, 07 Jun 2024 18:40:41 -0700 (PDT)
Received: from localhost.localdomain (140-211-169-189-openstack.osuosl.org. [140.211.169.189])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6bd7ccf80sm41270955ad.160.2024.06.07.18.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 18:40:40 -0700 (PDT)
From: Zhouyi Zhou <zhouzhouyi@gmail.com>
To: akpm@linux-foundation.org,
	pmladek@suse.com,
	masahiroy@kernel.org,
	yoann.congal@smile.fr,
	rdunlap@infradead.org,
	gustavoars@kernel.org,
	nphamcs@gmail.com,
	vincent.guittot@linaro.org,
	linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org
Cc: Zhouyi Zhou <zhouzhouyi@gmail.com>
Subject: [PATCH] init/Kconfig: lower to GCC version 9 check for -Warray-bounds
Date: Sat,  8 Jun 2024 01:40:27 +0000
Message-Id: <20240608014027.1118686-1-zhouzhouyi@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

commit 3e00f5802fab ("init/Kconfig: lower GCC version check for -Warray-bounds")
lowers GCC version check for -Warray-bounds, but I continue to see false positives
from -Warray-bounds in GCC 9.4.

This happens after
commit b44759705f7d ("bitmap: make bitmap_{get,set}_value8() use bitmap_{read,write}()")

During the rcuturture test in Ubuntu 20.04 GCC 9.4.0 x86_64, the compiling of
drivers/gpio/gpio-pca953x.c issues following warning:

```
  CC      drivers/gpio/gpio-pca953x.o
In file included from drivers/gpio/gpio-pca953x.c:12:
drivers/gpio/gpio-pca953x.c: In function ‘pca953x_probe’:
./include/linux/bitmap.h:799:17: error: array subscript [1, 1024] is outside array bounds of ‘long unsigned int[1]’ [-Werror=array-bounds]
  799 |  map[index + 1] &= BITMAP_FIRST_WORD_MASK(start + nbits);
      |                 ^~
In file included from ./include/linux/atomic.h:5,
                 from drivers/gpio/gpio-pca953x.c:11:
drivers/gpio/gpio-pca953x.c:1015:17: note: while referencing ‘val’
 1015 |  DECLARE_BITMAP(val, MAX_LINE);
      |                 ^~~
./include/linux/types.h:11:16: note: in definition of macro ‘DECLARE_BITMAP’
   11 |  unsigned long name[BITS_TO_LONGS(bits)]
      |                ^~~~
In file included from drivers/gpio/gpio-pca953x.c:12:
./include/linux/bitmap.h:800:17: error: array subscript [1, 1024] is outside array bounds of ‘long unsigned int[1]’ [-Werror=array-bounds]
  800 |  map[index + 1] |= (value >> space);
      |  ~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~
In file included from ./include/linux/atomic.h:5,
                 from drivers/gpio/gpio-pca953x.c:11:
drivers/gpio/gpio-pca953x.c:1015:17: note: while referencing ‘val’
 1015 |  DECLARE_BITMAP(val, MAX_LINE);
      |                 ^~~
./include/linux/types.h:11:16: note: in definition of macro ‘DECLARE_BITMAP’
   11 |  unsigned long name[BITS_TO_LONGS(bits)]
```   

Disable gcc-9+ array-bounds avoid above warning.

Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
---
 init/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/init/Kconfig b/init/Kconfig
index 72404c1f2157..27ce2ded95b6 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -876,14 +876,14 @@ config CC_IMPLICIT_FALLTHROUGH
 	default "-Wimplicit-fallthrough=5" if CC_IS_GCC && $(cc-option,-Wimplicit-fallthrough=5)
 	default "-Wimplicit-fallthrough" if CC_IS_CLANG && $(cc-option,-Wunreachable-code-fallthrough)
 
-# Currently, disable gcc-10+ array-bounds globally.
+# Currently, disable gcc-9+ array-bounds globally.
 # It's still broken in gcc-13, so no upper bound yet.
-config GCC10_NO_ARRAY_BOUNDS
+config GCC9_NO_ARRAY_BOUNDS
 	def_bool y
 
 config CC_NO_ARRAY_BOUNDS
 	bool
-	default y if CC_IS_GCC && GCC_VERSION >= 100000 && GCC10_NO_ARRAY_BOUNDS
+	default y if CC_IS_GCC && GCC_VERSION >= 90000 && GCC9_NO_ARRAY_BOUNDS
 
 # Currently, disable -Wstringop-overflow for GCC globally.
 config GCC_NO_STRINGOP_OVERFLOW
-- 
2.25.1

