Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ADEC15ECD2;
	Tue,  7 May 2024 09:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715074564; cv=none; b=dypMjQxxREDpugB6X9lK8PTB3eI/lFXFZZZCLobOFlKsxyHVkBI87dj9c0X4/fW/qMwv4gXrK3TEvLORjthUtXyNo9BZDQ8EdZQmLU7+lSjcD9MGec5p0vMORsSp9JtPRJUy0BHPcvi/8jdpieGA5tbwi66L32iFtvMhSyz+Tv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715074564; c=relaxed/simple;
	bh=L9yyqsasGcBRwTVVl5BvyZK7asmI7UPEWvqiN+AHkfY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NbapZE0U4yjDjGyGt0h/NXLjLeEyxkceDitsec7fAjNmpYoSpaGFPtUbY3us6rPsWiC7LdKIoqtk+T2OtXlLY97kKZNMsmiAdtivX6i3kMPVNpDTDU1Z5zSUMshSaXdQg0xrFD95awZGSJ8pKOcaj0aR2B5BAsa6/c3V+S7FR+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OFBIqBY/; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OFBIqBY/"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2df9af57b5eso38862831fa.2;
        Tue, 07 May 2024 02:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715074560; x=1715679360; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w1tkz/C4aSczVsYDDvrLDAru1oEnBIKM9qUQq3rJqNA=;
        b=OFBIqBY/penvTFEvzDMkB83jyhUCTSiIYdGhLomlYiwBDYeNDQv3O9kDTT3p7ISOjC
         kxe1nE6LP9fg3IuC06wPb6aRT13ohfemTHR7/mPBZSHZgMh2NC8VYVOsMY04P2pcdMbV
         5Qv+ekTH0G+ojyY7NdmbcSecAa2Rnk0NT7+PBBSOzrdco6Wir+PcR5StByq1SaFf1/+F
         V/nWL0leuSf89pQmsDP5WjfoEylyzIUG6QtNqyEJMB4Th/yYOYNg1FhDUZNljfsOKDaM
         QpC0F++ofZgLNTTYMXM9aYL/x/rC/rXOERxn/E00jCR04owKTCgevuzAcpD2EeCJhMup
         7o0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715074560; x=1715679360;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w1tkz/C4aSczVsYDDvrLDAru1oEnBIKM9qUQq3rJqNA=;
        b=X/ZmyBFVeXIPmeBIdZwo9TCkQp1uOdvlaQdVIC2e6arNtfBE9f0YNKlwZciKwzU+lW
         VnAOru9QyaNGX9xSf87uzo18xBReqiLwsD2sYUNeR0QB9CIcAjqLeLx3LC/y/RGsxp08
         ygaD4u46qbwS6US1Ck6i7W+TqHSs4ZCxH9Iu+bCoO5iMVEzwlA0EiimIQJrKzSquSgNz
         42eNXrCcSgctO5ZYUaiQl6i7Or4IJnvygK0HzvmTcrD+yeuiWGWJXE1mJL6MicPXb6tN
         HXc3cvDhdqCbm6C2NK9Sx7p4x+ELtAaylrKGt7qr9lphEN301TrKNe88czQ9FqsCHrl1
         79Qg==
X-Forwarded-Encrypted: i=1; AJvYcCVlWeOrC+tUXHbotycASOOz/WE/LYlvLvYg2tghGWBCHvRgHC6pv41UuHHjJuRyziOGjs2EwibAZXyDoTK2runv/6Ncsen8s+JWqCCE
X-Gm-Message-State: AOJu0YyVNABP9XfEoOu0Zg1SCXWjalCoxVUet3hlyTUNCHTlPHzQKoaU
	swJoeBJwASyEBH1o6bWfF/ETTvbcCg/XsemtVoNnDxDq+1rnD58t
X-Google-Smtp-Source: AGHT+IEe29Z4B5o9+JvHcbUN9sMcQQWlKTFt0TCj3L378xX+JENFQMwDnGLqTaJiYVlrjSE+Qd/rhg==
X-Received: by 2002:a2e:8904:0:b0:2df:4bad:cb7a with SMTP id d4-20020a2e8904000000b002df4badcb7amr10088812lji.0.1715074560360;
        Tue, 07 May 2024 02:36:00 -0700 (PDT)
Received: from pc638.lan (host-185-121-47-193.sydskane.nu. [185.121.47.193])
        by smtp.gmail.com with ESMTPSA id t18-20020a2e9d12000000b002e29c50c4dcsm1335473lji.27.2024.05.07.02.35.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 02:35:59 -0700 (PDT)
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
	Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH 29/48] rcu: Remove redundant CONFIG_PROVE_RCU #if condition
Date: Tue,  7 May 2024 11:35:11 +0200
Message-Id: <20240507093530.3043-30-urezki@gmail.com>
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

The #if condition controlling the rcu_preempt_sleep_check() definition
has a redundant check for CONFIG_PREEMPT_RCU, which is already checked
for by an enclosing #ifndef.  This commit therefore removes this redundant
condition from the inner #if.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 include/linux/rcupdate.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 2c54750e36a0..382780bb60f4 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -401,15 +401,15 @@ static inline int debug_lockdep_rcu_enabled(void)
 		}							\
 	} while (0)
 
-#if defined(CONFIG_PROVE_RCU) && !defined(CONFIG_PREEMPT_RCU)
+#ifndef CONFIG_PREEMPT_RCU
 static inline void rcu_preempt_sleep_check(void)
 {
 	RCU_LOCKDEP_WARN(lock_is_held(&rcu_lock_map),
 			 "Illegal context switch in RCU read-side critical section");
 }
-#else /* #ifdef CONFIG_PROVE_RCU */
+#else // #ifndef CONFIG_PREEMPT_RCU
 static inline void rcu_preempt_sleep_check(void) { }
-#endif /* #else #ifdef CONFIG_PROVE_RCU */
+#endif // #else // #ifndef CONFIG_PREEMPT_RCU
 
 #define rcu_sleep_check()						\
 	do {								\
-- 
2.39.2

