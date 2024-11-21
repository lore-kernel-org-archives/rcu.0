Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68341C877E;
	Thu, 21 Nov 2024 23:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732231330; cv=none; b=uaktNs6Wzz0DshxP3fbdhEWGzq4CI6k6gj+OxQ5fY9vFU74zKi2gVze5RIXIV17hwXHps+o8THw3GwK8NfIH3mFI42vCK9O7XL4qVcxEekCx1KoHNhBiPNZdCj2W8TXWkmDKxm7ty+7HpPhY0jgMVk169E1n4wzz2HJZXN6zlpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732231330; c=relaxed/simple;
	bh=zJto9ivipYO/WczCa6h8ub6o8ToZHi4kGGeDz8cr/kM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GVd6m+hitlcHEZwMRCeLZIF9mEglbCGTv7UZatHAwCTQdA0Sz9R58oPwlCd6Tef/cdBrzEdqgnRxzR917AYg5fXg1/UaNL/t8eD5v4LhQx024oIRq4mDhjvzaJQMDLr29FNDb23ASNXYFc8mnOmyVW1IahdU/+u4EgQ/VSpDaWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S+qiXZJu; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S+qiXZJu"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-21290973bcbso13397105ad.3;
        Thu, 21 Nov 2024 15:22:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732231328; x=1732836128; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0vm69DWsgNi7OPxvs0iEX7zCR+55p7Oued1bSDUQ/MU=;
        b=S+qiXZJuJ/jKcZBlmujwTPUdFwYWcXZjbX7lGKxjw+3dtwSrcYXHyaXRbcBtkCyioe
         gmO09NQTZuQQSVRGKIBhLH8jHHqPTl+wOtcYRDAR3TeiaXHccQLfGWOCaqNpTBz5T9ZM
         JGvphjV+uifXwUxQm51tfa3Xb8F8RLmT4qbCrc3u6792BIZUGX3pwNiukgwlaqQWPH9h
         ec/Lo2tyWxZ3JiaEA/4YWwXyMMwxjzDpxBGmYJhJuUWWGjNTWuJl9Ufwx83rpsx7Nkck
         1CklrXXLofn6QqHBVY7rQUWJYDmyNd+3T8ZtwpFHPblrv0GA8naR4+Xrx4swu8+hadkK
         RIVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732231328; x=1732836128;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0vm69DWsgNi7OPxvs0iEX7zCR+55p7Oued1bSDUQ/MU=;
        b=Nui6CY27FxV1ux8QpPsw17rcY2wmNsZmS+AH7ICp/Bf2BODYaKXSd217IOyQVwm1gY
         jYIcD8RNK+NSC5ZT4BMMK1BxJzTrJT1hlYn495BHXzbyP6xeWCoCIFQ4gjlcM4nWidf0
         NY1gAa26XJnqhPr/tau4hG9RRdtsr81su0zsxLK7Va4Vf2p+XZvRFB7ICB6VYVkcKSQt
         omPYrXCRYvxTecCKzf5CiSLgLkvFM8yNPBZzcToV9G6FrFMo4KX/AU8DG621C+UKQfGs
         FYeSgw05fqh1VpTphQYF4vJXZlYUMcqoDUJUtUB6UwZHx6u5hP7X6SynnEi2ejpzoKbe
         Cl5A==
X-Forwarded-Encrypted: i=1; AJvYcCUokJorjaUCEZimaMkUReLVm9riAep2oLfbH/ZWUE8W1DVaY5+4V/z+QzfzF1u0qapo5IN1rkbk19Q=@vger.kernel.org, AJvYcCWmBZgV7844vmClXsHPYrDZW9zbbebRm15WrC2xKw/LF9XuywdvuNUigzELV83JfItwGFweHXcPoezGxKvV@vger.kernel.org
X-Gm-Message-State: AOJu0YymnNW8cJ7JE5jw9RXDfKHQJL8/fAnRKz+eebTGv5THSJoMaEsX
	MsVShXoVptn8Lm2551GwFB45rRtyQEh+H0e71G+/Z+c9X/n2gL8=
X-Gm-Gg: ASbGncu+T1VkLOQ4oW5AkaLj4FfU1wa07IBshdL5AAX/2ujLdTdwGfv9FzRzGuZgDLL
	DT0kP31ZFpr48NllC9QR+PwqQJsWWFEt+pi45zUhFxW6w/MPyb/TpSi/lDa5BeilOPSQJ9FABqW
	40ItgMjj6KHsSkT0KBSqe6mqTPrlQMJ1O7Uq8F4+DxdlU9r9qTuV8vtmY0y3TA9i79TAwfaIc/v
	EyAeywSHKFsqBfT1akRdxkoZdHxc5XBV99FAT/BkpjhOsLp8zEfheLImXO4zxMk7JzcpeGUok0=
X-Google-Smtp-Source: AGHT+IEHh7R4wlQqsgbzY9raVAXjnSU/BtLMAx0J6wGaA53zev1YKSp/g3R6QLautUbNQx+eB11DTw==
X-Received: by 2002:a17:902:dac5:b0:212:500:74e with SMTP id d9443c01a7336-2129f51d2c6mr10558855ad.11.1732231327941;
        Thu, 21 Nov 2024 15:22:07 -0800 (PST)
Received: from localhost.localdomain ([117.250.157.213])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129dbfee73sm3688875ad.150.2024.11.21.15.22.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 15:22:07 -0800 (PST)
From: Vyshnav Ajith <puthen1977@gmail.com>
To: paulmck@kernel.org,
	frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	joel@joelfernandes.org,
	josh@joshtriplett.org,
	boqun.feng@gmail.com,
	urezki@gmail.com,
	rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com,
	qiang.zhang1211@gmail.com,
	corbet@lwn.net
Cc: rcu@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vyshnav Ajith <puthen1977@gmail.com>
Subject: Fixing Spelling Mistake in rculist_nulls.rst
Date: Fri, 22 Nov 2024 04:51:18 +0530
Message-ID: <20241121232118.13507-1-puthen1977@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

NUll is a special marker and not maker I believe. Fixing typo with this patch. 

Signed-off-by: Vyshnav Ajith <puthen1977@gmail.com>
---
 Documentation/RCU/rculist_nulls.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/RCU/rculist_nulls.rst b/Documentation/RCU/rculist_nulls.rst
index 21e40fcc08de..88bce14b3c37 100644
--- a/Documentation/RCU/rculist_nulls.rst
+++ b/Documentation/RCU/rculist_nulls.rst
@@ -13,7 +13,7 @@ Please read the basics in listRCU.rst.
 Using 'nulls'
 =============
 
-Using special makers (called 'nulls') is a convenient way
+Using special markers (called 'nulls') is a convenient way
 to solve following problem.
 
 Without 'nulls', a typical RCU linked list managing objects which are
-- 
2.43.0

