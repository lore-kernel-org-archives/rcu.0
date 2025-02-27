Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBDAD22F14C;
	Thu, 27 Feb 2025 13:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740662181; cv=none; b=V0osnzlD4cbCPR6uLtpaE9KiL3r6I2DctWXgK0buWxbwzFjeHZkCwj26129ym6DIQObGVpIpW4nUARHZ/GxPJ13GFwBE1EPWCcTsPvfFVZ1qqy7K79yWczqT2mlErDatRKFe+AQqGgR0+w+EHLVKC0+t7bsSbpX0MFqV4q7urWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740662181; c=relaxed/simple;
	bh=sCuflgFUh/45tShowZi3ebLKyBuj3+UPfLcwZ/CRsbA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M06N2ZIxJAib6oiWsLMjHl8bkn45DJWTbevCv3DSzafv886AcMI3SUBqzJdrwJyxBz0fQRhRFg6GiJiubnxhUJQOsjvw/O7jD5igUpBmSM982w5hTjQYkJML1dStiIL+7OrKANdbf7/gGio47wQbpXIRuB02YURZKA1j2uLyyYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sxv6UsKU; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sxv6UsKU"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-548878c6a5aso942996e87.3;
        Thu, 27 Feb 2025 05:16:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740662177; x=1741266977; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c8AAp3JK/Rr4QIILXNDXheLWWABxs1/zeQyrDjipUFA=;
        b=Sxv6UsKU8S4oxPoR782vGz98TNKn+I8dhEeTUmpzJ83kS/nhW6l4tBbeORR1Ln68/r
         Lwu6KaCe29zk45yQWk/U+MT4Rfh+751iOFuOJZv57WwTmVKdc0tPLguc5bs3w1IN/coG
         m/r9d0ThR6zudnCsCBqmofRvsi0lROlllVsT+jsS7/jzuRf6xgPbsHKxqD/qZYJLtlBT
         i3P2C3GhOoqOZYw2ha8ZK/S9rRGEtFX/Czl4rwxM3LCqZMdZXplh0ocukRTe/7+8rmOf
         QaLd/ebWAI+88cpfOQTHeeHB28RQ+at9t8KGjlgCbvibAnLdEzkfKsuqsCgXAacHz3yc
         723Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740662177; x=1741266977;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c8AAp3JK/Rr4QIILXNDXheLWWABxs1/zeQyrDjipUFA=;
        b=OXs6GLzjZvxb2oG+pBxC6euOxOQcuCysyV7T0QGzMqTTsk6aZ4KzUBwDqq+n8K4UPm
         8R93/S7pAHGwCma1eiS3hEHU0Jk8ddudbfcB16D0AUk7d9IJGqQsPjh9r2rnng50Sn2+
         4lnK5B17NNB/rQ+BNe911XToFAekkplvdMFi2tLJAkA/TyKNOS9R2eYEDlJ7XL7rB/uz
         U6/AnFkALmHo/v8R2fG+h+ji8Xi1wwrokawiHzo1qjxSUL8rUBo+s/qw5NKtwgYSJ3c0
         f/9DL41GU5XzEeDiPJvZx9bGrAyQR1SIlR58zqnWKjsW6YfY7J/WUwp6B7qckf9VId2J
         A2Bg==
X-Forwarded-Encrypted: i=1; AJvYcCVwzlvmwCiHfeTNeoP6zWSukF1qQFf8hZhqZF+asdhUUbccsdjdmfFNgI0RB92FN3m7dAQmyj/hKiDEou4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyjntj9rtTBShSJVqytcgQVbEBMgblLTluSsTSlVY0dL1afA9Or
	Snw8urgtNmO3BYfFpd5v2wRW+QOD+bFIl3uPaWtVKGfnBJx+aVFe
X-Gm-Gg: ASbGnctaX6q6E7NsGcBfX1XnfaI1qm7FaLwc/7mN/UspZ4gXc86aPaaNpidrl7+wX57
	DHtaW5ZH/h1CYgv0yj7BIiShChgVCGChZIG0I2yPEcGi4CXmkv7TzjelBPerOZxkg4Mkg6U+kNX
	C6Pq78nApRUzyS3Q7FTkRX+sHP+XLsE+6ZuNk7s6LvFwJexyEO2LZUPSw3iKOSRWUgU8n50+9U4
	EkhVyMwCRDQR2lFCqir7UGKKgYFIYNkB8uZZ1F4FX7ZyYAtFSaLf892VeE9Avker8PZql1j2hKl
	mxq05WAHh8NHmUgskj7mXQ==
X-Google-Smtp-Source: AGHT+IHZ/jBMlPBzbVt+Pzr47YFlraPAhvrc3ZDpG6flGs1b474L4atBlzhUgMjrGmLvIUsAJlMPTQ==
X-Received: by 2002:a05:6512:b05:b0:545:2efc:7458 with SMTP id 2adb3069b0e04-54839259c52mr12365327e87.39.1740662176526;
        Thu, 27 Feb 2025 05:16:16 -0800 (PST)
Received: from pc638.lan ([2001:9b1:d5a0:a500:2d8:61ff:fec9:d743])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54944174505sm157011e87.37.2025.02.27.05.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 05:16:15 -0800 (PST)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: "Paul E . McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>
Cc: RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Cheung Wall <zzqq0103.hey@gmail.com>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: [PATCH v4 2/3] rcu: Update TREE05.boot to test normal synchronize_rcu()
Date: Thu, 27 Feb 2025 14:16:12 +0100
Message-Id: <20250227131613.52683-2-urezki@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250227131613.52683-1-urezki@gmail.com>
References: <20250227131613.52683-1-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add extra parameters for rcutorture module. One is the "nfakewriters"
which is set -1. There will be created number of test-kthreads which
correspond to number of CPUs in a test system. Those threads randomly
invoke synchronize_rcu() call.

Apart of that "rcu_normal" is set to 1, because it is specifically for
a normal synchronize_rcu() testing, also a newly added parameter which
is "rcu_normal_wake_from_gp" is set to 1 also. That prevents interaction
with other callbacks in a system.

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 tools/testing/selftests/rcutorture/configs/rcu/TREE05.boot | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREE05.boot b/tools/testing/selftests/rcutorture/configs/rcu/TREE05.boot
index c419cac233ee..54f5c9053474 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TREE05.boot
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TREE05.boot
@@ -2,3 +2,9 @@ rcutree.gp_preinit_delay=3
 rcutree.gp_init_delay=3
 rcutree.gp_cleanup_delay=3
 rcupdate.rcu_self_test=1
+
+# This part is for synchronize_rcu() testing
+rcutorture.nfakewriters=-1
+rcutorture.gp_sync=1
+rcupdate.rcu_normal=1
+rcutree.rcu_normal_wake_from_gp=1
-- 
2.39.5

