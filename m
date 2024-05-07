Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B25D14E2C5;
	Tue,  7 May 2024 09:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715074548; cv=none; b=E+/mqNBxCtprWONjs0vdIpHjW0pjsaktBmxVq4HzGTO22Ytazf0BNU1+ngQ1loTWZgk2jy2NQPu+rO/+XXQPnOxPOV7zWjlhgNsnaCQjt1EOnyefZPnig3CJxsHlVrS8q80Hf0jgubOVQ4OCEaeHk0rD4ayFIr2eExP8Ny0L8Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715074548; c=relaxed/simple;
	bh=c3pcsZaBxcT4XT+/DSNV8MoonKro3JB3EF7WT41QDgo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gTnfph66XkSo4PxbrRMzxL3/WUT9kpQKsZovy5sMmCJjJIld4Qw8IZv7ZzyIzNL6SuYDzqRJsIUqK7iir9OHNguDdgwOWzensLnm8ArNkZXbZTC7zvLbBMJSdfsLZGmr2mHcZrGM/zON2UL31q6WUo7JJ8Z0EXxsmPGhIQosa7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a4xsB7hq; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a4xsB7hq"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2e3e18c24c1so8120471fa.1;
        Tue, 07 May 2024 02:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715074544; x=1715679344; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FsT5Z8z8aN6DXWEnnpzj6QsDHO6m4UY1ubPVXNAMDxk=;
        b=a4xsB7hqMWfEN3NzSH3webJm8hFIIfwR8d3fZ8or1WjskJf80awDuYRRcBXVDWR6nv
         2Epk9/DCjwOkTZfxD43VlTEDsU92JR6g0Boodu3WBcn0OPPtMXo3S3j8NGEmy4KVs652
         p3rQ+Qmd+sjvEb8b4rys4BerseJNFn5T8Q/sPthcMfdI+0Oqd8GczFeadPidZKExNb5u
         TBnL4bllV1woELD/wcEdO5C02r5Oar+x94G6aN7/4YAwDQUoF1IrEdI3G/5T77SGs/4Y
         WIrIumzWpZ3K1OnxAEtbqM7ACIZTAeF9FE3JhACH3sIB7YWE+g63SwhjiJ3/6scTmYtv
         VeKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715074544; x=1715679344;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FsT5Z8z8aN6DXWEnnpzj6QsDHO6m4UY1ubPVXNAMDxk=;
        b=ggmcTdQ40Hhy0kRtYyI95XdqdJcGoLT7jJhqldfqQTAJDRRs1DNS0QmBosDTrDccxD
         JF5lXznSsAXO86gYv4xF1iw1XxIYELwxdrIM2wGKyJYr7r7z64/Gy049ToRoO1+XFlQR
         zU8+cgp6hwX1MPrHxKT38eSF0A0yVqNwn5DciwNarZ3NHLdux59+SImHaZ8XfbD//w/D
         MPE+wdP2eR/kG6c+tX9eTxiRJGXvhWWWFV72KDSz17WIsf+HtKXT+hHV4gjJfd41QgyK
         qpiiJK1wNXgg85i7zRlzp0zTSWF/VLmgjaJ2o/IgJyye6+wTDSBtSSirUU8Jp1t7e9C4
         mo2A==
X-Forwarded-Encrypted: i=1; AJvYcCUC6s8OdAfkQ6FhztqBLK4i8F3gMIOTZMcuIWKQRN7Q+DwpmSTc+LHjIa1jysCdFb0fdILVthkJEZrfpMPQDAID8lyR0UD4s6vD1vxK
X-Gm-Message-State: AOJu0Yx84UZq4xTkVT72+UCE3LOTWZEu6M4rcd0ciThxGoJVB6j6ICi6
	8JofTPl7JeDmOkQjceEXCJ6F0lkLQnd6pO4w51crm80TsdwFKGqZ
X-Google-Smtp-Source: AGHT+IGK8gvnE0HOnK8b+PD2X5+MiPLLyDqmSDCByUZIin09SOHuRMpEFOiPchdlCxr/6LB0pCOnGQ==
X-Received: by 2002:a2e:602:0:b0:2e3:cba4:234 with SMTP id 2-20020a2e0602000000b002e3cba40234mr1710352ljg.10.1715074544568;
        Tue, 07 May 2024 02:35:44 -0700 (PDT)
Received: from pc638.lan (host-185-121-47-193.sydskane.nu. [185.121.47.193])
        by smtp.gmail.com with ESMTPSA id t18-20020a2e9d12000000b002e29c50c4dcsm1335473lji.27.2024.05.07.02.35.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 02:35:44 -0700 (PDT)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: "Paul E . McKenney" <paulmck@kernel.org>
Cc: RCU <rcu@vger.kernel.org>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Hillf Danton <hdanton@sina.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Heiko Carstens <hca@linux.ibm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Douglas Anderson <dianders@chromium.org>,
	Ankur Arora <ankur.a.arora@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH 12/48] arch: Select new NEED_TASKS_RCU Kconfig option
Date: Tue,  7 May 2024 11:34:54 +0200
Message-Id: <20240507093530.3043-13-urezki@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240507093530.3043-1-urezki@gmail.com>
References: <20240507093530.3043-1-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Paul E. McKenney" <paulmck@kernel.org>

Currently, if a Kconfig option depends on TASKS_RCU, it conditionally does
"select TASKS_RCU if PREEMPTION".  This works, but requires any change in
this enablement logic to be replicated across all such "select" clauses.
A new NEED_TASKS_RCU Kconfig option has been created to allow this
enablement logic to be in one place in kernel/rcu/Kconfig.

Therefore, select the new NEED_TASKS_RCU Kconfig option instead of the
old TASKS_RCU option.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Douglas Anderson <dianders@chromium.org>
Cc: Ankur Arora <ankur.a.arora@oracle.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 arch/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 9f066785bb71..ae4a4f37bbf0 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -55,7 +55,7 @@ config KPROBES
 	depends on MODULES
 	depends on HAVE_KPROBES
 	select KALLSYMS
-	select TASKS_RCU if PREEMPTION
+	select NEED_TASKS_RCU
 	help
 	  Kprobes allows you to trap at almost any kernel address and
 	  execute a callback function.  register_kprobe() establishes
@@ -104,7 +104,7 @@ config STATIC_CALL_SELFTEST
 config OPTPROBES
 	def_bool y
 	depends on KPROBES && HAVE_OPTPROBES
-	select TASKS_RCU if PREEMPTION
+	select NEED_TASKS_RCU
 
 config KPROBES_ON_FTRACE
 	def_bool y
-- 
2.39.2

