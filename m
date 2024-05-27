Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64BFB38C;
	Mon, 27 May 2024 01:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716772840; cv=none; b=Gy3RJ36OWPfGyjerR7Rv+ds734yezBQSlnClHiCz5nWYMvzWWTjGQ1E2P4BuGSJTOjfIYO67IfnYaQa4SFKKKfxBzUE3ODwqqL7UNlP67FcGYRCCh7m7hm1PJ3PGDZiPZ6peAkQcX6aFoza1EoGexARu6k71NY4UM7zUaROThuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716772840; c=relaxed/simple;
	bh=rsHE6Mu1s/qv+KuDTC+rab5Yqipak136+qejm32MZpA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=ADMbNEjyEwMEdilfKc8tBgevsWuE6wL9SmOYdXsbykh8lqRX8UiPHjraP6DfG2UoEiKyAx8Tm+zYugyFUt9Hphwpo5BUnY2c5Q2I0QsRl7G3qfYxjNGD8srgIPlljj5FhCgMZMXL9fSG6kI7H20w6RYqJMUpFsvGYhgy5ETvgKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kVT6o22m; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kVT6o22m"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1f44b5d0c50so17319785ad.2;
        Sun, 26 May 2024 18:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716772839; x=1717377639; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zhri0/vJdPUtS20mPiUHFEviHxNxww/w5KVtbT8fjLg=;
        b=kVT6o22mJ/2XK0y77qMEmi34Q7c+whUgKYTVl8n6qvxDZCU/Qbq0X2/3UrbCJhAR2r
         CNocTFvk6h9TWyWHFJvvZwJvZWn9t7rXpaW2iO3kkjeqbSdAa5kJq4nDjsbKkoapemJn
         WKVgApAir9qMNSwWW9OGzdkx9omjs2SoVJ4GrF7n1aV09KIPJcDmtUgqGwLke6sPAp/g
         SYik3uEjSlgv+LDNSoxgGQHvNsANGWZeIJo6x4C4zAMBiNU/29IuzaTcw/tvUZ3/dAHH
         u/520MKdYuNnG/hD8KjrPqmnKDvFHq2MKeHmrgI+DjgIHcH5Ha4CIOGqR2o3wyUWbLVo
         /gOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716772839; x=1717377639;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zhri0/vJdPUtS20mPiUHFEviHxNxww/w5KVtbT8fjLg=;
        b=t+hYDpnUaNGrFrulDSImhE8zO1jrR5cHdYPpTT9mQnyQ/y5qRQDdsx/+41Vu9gMvVN
         G22CBYoGbPYNxfot8tZOoW8WYoFinmPOzM+IaIzDqDqkhctDQwetOldFnlurJuyBY9NP
         HUm95rxPERYnra9p/J5ES3nBM99Wo5RHd2CiN6pkRrsvp4J+vXwyYGvRMd78trMvtsFR
         jcaUzTRzQ4oizZJH+F+pb7xhW0RoyLzpuUjYA4sBXRy87SNa4+Ixcp0ToluhRp4KpLyv
         r4gO2QusRsbosWZ9OHe712wXj3f81jl/EYj1RpZ3SoZrG0rm+3Z89U5FGzoBpetrRm7C
         bb/Q==
X-Forwarded-Encrypted: i=1; AJvYcCW6PJ3rt2OZem5fpqcXELRZm04bl4TU2ws8iv8ftqmkF0ilgrx6vmsWOsT6EDmAiGFZeMBXSt79Nc2LndIRrKAELP3N6h1y2ER5i62cKVLL7UnmJo6MO6zrQwVxqfjh3wj+
X-Gm-Message-State: AOJu0Yyurt/Dorp0AeJnzFbrtvb6gAiwEf1QdEbkwB4+J9Az0/RT7IBd
	PfAVnZBE7N655GN6Wg+Y2Kn/GmXpZddZg0sPU+Uj5fXMJF9rzm+O
X-Google-Smtp-Source: AGHT+IHs+AGu3AGCAaE5Icw6Mlc/9MAd2UZwxY4NIOH0MIQi/OpFV4Y12FGLctWzh8VZElCVzpEiVw==
X-Received: by 2002:a17:902:e810:b0:1f2:fab6:294 with SMTP id d9443c01a7336-1f4498e18f5mr89572135ad.56.1716772838461;
        Sun, 26 May 2024 18:20:38 -0700 (PDT)
Received: from localhost.localdomain (140-211-169-189-openstack.osuosl.org. [140.211.169.189])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f44c9a8464sm50370265ad.230.2024.05.26.18.20.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 May 2024 18:20:38 -0700 (PDT)
From: Zhouyi Zhou <zhouzhouyi@gmail.com>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	chris@chrisdown.name,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org,
	lance@osuosl.org
Cc: Zhouyi Zhou <zhouzhouyi@gmail.com>
Subject: [PATCH] drm/radeon/r100: enhance error handling in r100_cp_init_microcode
Date: Mon, 27 May 2024 01:20:18 +0000
Message-Id: <20240527012018.351223-1-zhouzhouyi@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In r100_cp_init_microcode, if rdev->family don't match any of
if statement,  fw_name will be NULL, which will cause
gcc (11.4.0 powerpc64le-linux-gnu) complain:

In function ‘r100_cp_init_microcode’,
    inlined from ‘r100_cp_init’ at drivers/gpu/drm/radeon/r100.c:1136:7:
./include/linux/printk.h:457:44: warning: ‘%s’ directive argument is null [-Wformat-overflow=]
  457 | #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)

Above warning is emitted during the rcutorture test in
in PPC VM of Opensource Lab of Oregon State Univerisity.

Enhance error handling in r100_cp_init_microcode, let r100_cp_init_microcode
return with -EINVAL when none of chip families is matched.

Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
---
 drivers/gpu/drm/radeon/r100.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/radeon/r100.c b/drivers/gpu/drm/radeon/r100.c
index 0b1e19345f43..4f8a1bdd9365 100644
--- a/drivers/gpu/drm/radeon/r100.c
+++ b/drivers/gpu/drm/radeon/r100.c
@@ -1055,6 +1055,11 @@ static int r100_cp_init_microcode(struct radeon_device *rdev)
 		   (rdev->family == CHIP_RV570)) {
 		DRM_INFO("Loading R500 Microcode\n");
 		fw_name = FIRMWARE_R520;
+	} else {
+		pr_err("radeon_cp: Failed to load firmware \"%d\"\n",
+			rdev->family);
+		err = -EINVAL;
+		goto out;
 	}
 
 	err = request_firmware(&rdev->me_fw, fw_name, rdev->dev);
@@ -1067,6 +1072,8 @@ static int r100_cp_init_microcode(struct radeon_device *rdev)
 		release_firmware(rdev->me_fw);
 		rdev->me_fw = NULL;
 	}
+
+out:
 	return err;
 }
 
-- 
2.34.1

