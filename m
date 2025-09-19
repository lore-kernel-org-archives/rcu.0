Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336601A7253
	for <rcu@vger.kernel.org>; Fri, 19 Sep 2025 01:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758246435; cv=none; b=dEJATJc/X7kbKedT27u5G5tGPuEupp6q3XSn2Rcqj9ky2efcGESViaadF++OTkKv3cTAv1eH9sFx7BpsqN9d3ZVaON7sF4BaNdH7l4RYvvOqA6jaqjMzzVZuxmCY/1jHoFK+QJLujNWGXzlQEDFhYl2BHBIfU4gWsPjaT+5xccg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758246435; c=relaxed/simple;
	bh=tK7qZxWKS2HuhX167r9HRB0W9FfaI2Q3iMdOyh7NKV4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ADAPZ2PNNbwDgjs6pPz0GKQrL9lxNrfTG6zZNZYU2RSGtjKo2Izw/F7AWg64n0DNZl3Cj12qwd555dHqBa9PET2WTcDhnVQyQ9dxNqxw2xpOIjsb00OYxI1wLIbI6nBAzhxdXcBofYTipHkyL2s9VWQjel9+QIyc8uofT3+TCxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iqj9/Lnn; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iqj9/Lnn"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7704f3c46ceso1530811b3a.2
        for <rcu@vger.kernel.org>; Thu, 18 Sep 2025 18:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758246432; x=1758851232; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ctSrW8wbv38Mk10S7M7Ab4SdtyDnVEwCrq9dHNHgWY4=;
        b=Iqj9/Lnn+cCuAoT62r7WxCdNy9rFH2mEpCDNXJVkw0Ll9bnkgVSwmLLaqAXBf7VPec
         OUSx64e5B4UM8QJ2vfKo7HS0bHaRr+sneEY7y/aH1QMxQ7QOjvZxH1gedKx4ifn2KiTA
         PU4FycfiXe10DKzDmcOzE5kjkC1byn2MdpuYKFMzbYVbQjG3aVkZ0iEJxmWgvIoDMBXg
         lSVAAVvbkClKx80hb1Hry67IhVCMTEa9YFmk1f4zmLjvNivb/PEyAjjBOJo1iXhuI/yB
         dOCl5k7UqUsGlzRVeJ59Cq/G7onh5yph86q/EnHobJMsdc0cGnOZ6b/A/odPPWNQxpm0
         m0/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758246432; x=1758851232;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ctSrW8wbv38Mk10S7M7Ab4SdtyDnVEwCrq9dHNHgWY4=;
        b=X8OJJhRkCK30r8z97ezYmGcuQIYaFGx1YmOSqFNOzyYXxbrpPaU3vovn9jnfVWBaYB
         3PzHxUPiBSXFI4JNSFR6kFf4fj0eDLqEca01rSVWBRq2/m+nZZt7PR7OsDQypOIbeXem
         Km+ym13aA8VOsodunp1lgHpEEd980yQosR0rZHTDerFLzngq+LFfjpsby+U1iphhCyl/
         kZCh4SggrT8B5FU0KzNCsM+IIms6fJkHq+gRNN9pN4oX3jfOjy0fIHoZp+pQQ5u6QJfk
         5GZWBJkidZn/coaG0+OerkLR5ubBxbSyMEENsPqdd6drlD7c87Koo6G59m3FYTvIGXfZ
         a9dg==
X-Forwarded-Encrypted: i=1; AJvYcCU7o4zv6GDtRrDV1irEAG+7LGNfMluHjYUGyj96MYtYKhl+y3c4D9RW9T9Jg8oR26FoChM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yym9DuX5B84dRloUJflmZo0KwAzoe5dA1t1tQ8MK4uFq/BL0rES
	MVCRvB3Og7VTDzDHGMkcIDM+bMFYmiDA9fca4AqTdF+oNUI+wth17u7B
X-Gm-Gg: ASbGncvZd3yGzghCULfkH5eju0ggeXhicoBH/BAy/7fOckJ3yBRX9XfR2ul0mOUqJRa
	8n2CMRCWOc2bWGnvBtu/eSS+0ArJonZG3QEPTl86ND0ioMGV3kyXsCBcYmrq9IMOIa1qTiFRT3j
	SLiY77SflIAy49KJLNhefPMglD0TYueGZd2fzv4FIto7H3+IXK85vKtMcypwi6Q/krWBCsAC9AI
	sGecqWquyuBUpQf+542Gbi1gUo1OssRhNwUn6jrFr7ESAme1SuZ4WrO3X9QftDx7eSxQjvguP/A
	IR6Wa8WMNQ/rJivNJfENjRVaLMRBenPOYIqC1Nx/6NCbpudN+WBL5ZBLCHMfuqfndmIe/KE000S
	ufaHZqsemNqwqosI+/LjszcOt3DX7Jm+zR1uNqVXyqX3i+yqyX2fP0ydojiifJElved3+GEeOMw
	xZLw==
X-Google-Smtp-Source: AGHT+IHgzeQnEqpmnUs1J+YXPdqkcX/Yip9M+tbbNnqxQ78PLh+Qjx/qxIoFuDJdnI81p0BRulHRLA==
X-Received: by 2002:a05:6a00:178d:b0:776:20f9:71f7 with SMTP id d2e1a72fcca58-77e4d708a65mr1943903b3a.8.1758246432434;
        Thu, 18 Sep 2025 18:47:12 -0700 (PDT)
Received: from localhost.localdomain (140-211-169-189-openstack.osuosl.org. [140.211.169.189])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77cfbb79c2esm3618114b3a.2.2025.09.18.18.47.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 18:47:11 -0700 (PDT)
From: Zhouyi Zhou <zhouzhouyi@gmail.com>
To: w@1wt.eu,
	linux@weissschuh.net,
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lance@osuosl.org
Cc: Zhouyi Zhou <zhouzhouyi@gmail.com>
Subject: [PATCH v2] tools/nolibc: make time_t robust if __kernel_old_time_t is missing in host headers
Date: Fri, 19 Sep 2025 01:46:43 +0000
Message-Id: <20250919014643.2776037-1-zhouzhouyi@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit d5094bcb5bfd ("tools/nolibc: define time_t in terms of
__kernel_old_time_t") made nolibc use the kernel's time type so that
`time_t` matches `timespec::tv_sec` on all ABIs (notably x32).

But since __kernel_old_time_t
is fairly new, notably from 2020 in commit 94c467ddb273 ("y2038: add
__kernel_old_timespec and __kernel_old_time_t"), nolibc builds that
rely on host headers may fail.

Switch to __kernel_time_t, which is the same as
__kernel_old_time_t and has existed for longer.    

Tested in PPC VM of Open Source Lab of Oregon State University
(./tools/testing/selftests/rcutorture/bin/mkinitrd.sh)

Fixes: d5094bcb5bfd ("tools/nolibc: define time_t in terms of __kernel_old_time_t")
Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>                     
---
 tools/include/nolibc/std.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/include/nolibc/std.h b/tools/include/nolibc/std.h
index ba950f0e7338..3940778822f4 100644
--- a/tools/include/nolibc/std.h
+++ b/tools/include/nolibc/std.h
@@ -29,6 +29,6 @@ typedef unsigned long       nlink_t;
 typedef   signed long         off_t;
 typedef   signed long     blksize_t;
 typedef   signed long      blkcnt_t;
-typedef __kernel_old_time_t  time_t;
+typedef __kernel_time_t  time_t;
 
 #endif /* _NOLIBC_STD_H */
-- 
2.25.1

