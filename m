Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4544246BCD
	for <rcu@vger.kernel.org>; Fri, 11 Sep 2026 04:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789099383; cv=none; b=uSdoP96Odon2w9Osjd8LUzZ03YtCKi0dHPaEOeX6iO8QhstkKh8ymYdPSPqpZwIZwc9QQEjJMALEPnRL+uUIVOXbTJ2aXiRWGVvsNHNSbY1pdqzOaU/oNn5a8yYruUoMQtFqH1nWzflU7bJVueIyh7KkxIYomgmR6gNxYZYnFsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789099383; c=relaxed/simple;
	bh=ao6jIEmzwRgXagY/+AxCAmTno2+Fkib62A5EHCGLXaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=piJ3goDoZ9N7OC9bsPplJ7dByq2tLSRob8u+ABmAHSRuh385uG/rWpOzUIH1/eimLlQpVpW5ilMbU/1MvDnKK0evjB2txGbR6Dle78p8mzRJ4pVF8Xg2lqkjs5j6rXcYhhInHraCuuFUvk7k5SlnZ0ah8Gs/Wcuu1wyXaNb9B3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nMto2o+z; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nMto2o+z"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-ca12086c06eso522524a12.0
        for <rcu@vger.kernel.org>; Thu, 10 Sep 2026 21:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789099381; x=1789704181; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gEmUfzt/yqm9NkLjHUuAbAdVi/+qAz+6lDYXudPuDNM=;
        b=nMto2o+zYEie1SfUgxtCKPt7+CmntHiCIFWwLDVeQGy2/oOOPtHuvElDnqB2wynF9z
         bjK/SmilBXqY45o66e0DCJJOG6f2BkXIeW+DLrHnBKK2bbHfWyAz2sNmERXFdvNDS//7
         +0CgXUOxwDlfpH40kLLKmxtePq4Q+Fi4YU1PqZwSFnNpLItX/fnjcSmIWM59Wtmmawzo
         6x3Rc2RgnQeDvIOjv26zzOwrP+wVaMW5wkuwLlPwAO1pQysuLpf/CLxlAxB4ad3txSel
         jUiVGlgUSYkXZ7yXvlq3d6+Nc5FAOGVsYKO9OayQLZO3d2OVmCRSnnOA9adNVvr+xv9V
         6AnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789099381; x=1789704181;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gEmUfzt/yqm9NkLjHUuAbAdVi/+qAz+6lDYXudPuDNM=;
        b=s4UUqRi3sPOrMYPyeIeBCPS3Yqa0eqx5CGbG5uIBeoA+qR2UCdAv/3s5yjH3NkmSYF
         W5qTIbDwlPOwahkU1Jv8w0d6cuazwbakSJ7Fo4G5gjtRQRGUjWr09TeZJhCvxdEmcPlZ
         lr2jU3CFh1W1ZjhHZZn8YCTHy9D1z0DvJ85NZdicw/BeQWosh99RnASGciAYlFH0TA8n
         mj7kG2AnqlB8t2QxdVwK4z0Xb1vAg5W91aCkt+iXMITYqFFjSt/AA7ZKk7moqBsW++h3
         cEautNPGCf4YbeuwI/Mvo9Absb2AzmBoX3caRy+lmQJFy+BSUGQH8CyaPP1Y64kjShml
         nIqQ==
X-Forwarded-Encrypted: i=1; AKwUvBzNtbcwbsjsCmYnzf+p+TGByUkhoyD4vZIs2zfgZ4UBNz7KHiQOAt6Of190H5GI3Rny/FQ=@vger.kernel.org
X-Gm-Message-State: AFuF++kt0CMUjKx7ZaxCZKRegXqzpBUw24EdyR4V1zEq086s7et7RRsZ
	8RV9HsCDTMnhBM9tzHI0LyjUJ9G2VE/fVHbY8VRWLD1eXIq6P/vtSGa3
X-Gm-Gg: AYBFou2Z8podlGWDQqq1OY4e5mJxLZQiyxCEkgNtjpAtMtb1P4ZucQkIcA32eA8Mobj
	u5HvK3b/UcOl+Yr8kOw+/DzwEWT/PSbuykleYenYtMSHjoDfGkGdBM5bei1Zy6PIymgqafe/4A5
	R2C61HKH1peZ9qxwlcmIAUz08mmlSdziNzgUWE8gNvwFWtLmgZCFr2HI+WBvMFbZSyc7745tePS
	qizF4n5Xe7+s5kLyNCszHnKK2RSa+aaZle0LNKDIIw2NDaQDAC+K97u9dRZPeyJoK6LtyxJqADe
	OxfK6tV52fFon0GE9Kw15LfuO6GJ9A9XPRvXGSVBNLTrMEnR1V9N8ECRIjKJF4asco/SlTqxsgC
	T6+Xp2TlTjpZ4YD2fLHQIBd0Vkgl7qq909AKwZzmO+CpHBndzArV7TFsE9WAtXJgKBqJ//0hG/E
	NGCgdrpjhZoeCMV4HszGWeO5EcQ3fLaBk4HXSg5TQUMzZy2MrwxUWJUGdtZ2wYdoC2VT/SeDEV2
	ZCDxSumOVjykC4Tgg==
X-Received: by 2002:a05:6300:618d:b0:3cc:f008:8123 with SMTP id adf61e73a8af0-3daed153d75mr4492761637.8.1789099380642;
        Thu, 10 Sep 2026 21:03:00 -0700 (PDT)
Received: from kernel.tail6741c6.ts.net ([185.220.238.35])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc4c6599249sm480320a12.28.2026.09.10.21.02.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 21:03:00 -0700 (PDT)
From: Kunwu Chan <kunwu.chan@gmail.com>
To: jiangshanlai@gmail.com,
	paulmck@kernel.org
Cc: josh@joshtriplett.org,
	rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kunwu Chan <kunwu.chan@gmail.com>
Subject: [PATCH v2] srcutree: Skip torture to-big transition for atomic SRCU
Date: Fri, 11 Sep 2026 12:02:51 +0800
Message-ID: <20260911040251.618430-1-kunwu.chan@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Atomic SRCU does not use the srcu_node combining tree. Exclude it
from the SRCU_SIZING_IS_TORTURE() transition in
srcu_torture_stats_print(), and warn if such a transition is requested.

Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
---
Changes:
-add warn on an invalid atomic SRCU sizing configuration.
-v1: https://lore.kernel.org/rcu/20260910041427.3579817-1-kunwu.chan@gmail.com/
---
 kernel/rcu/srcutree.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 68441c32cebf..60c102a4d057 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -2422,8 +2422,10 @@ void srcu_torture_stats_print(struct srcu_struct *ssp, char *tt, char *tf)
 		}
 		pr_cont(" T(%ld,%ld)\n", s0, s1);
 	}
-	if (SRCU_SIZING_IS_TORTURE())
-		srcu_transition_to_big(ssp);
+	if (SRCU_SIZING_IS_TORTURE()) {
+		if (!WARN_ON_ONCE(ssp->srcu_reader_flavor == SRCU_READ_FLAVOR_ATOMIC))
+			srcu_transition_to_big(ssp);
+	}
 }
 EXPORT_SYMBOL_GPL(srcu_torture_stats_print);
 
-- 
2.43.0

