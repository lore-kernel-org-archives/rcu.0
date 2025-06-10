Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F0F1F4CB7;
	Tue, 10 Jun 2025 17:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749576897; cv=none; b=g67Xe/pRsJ/JZybGQbjllUBjzGaIcmkOOZOot97kM2oHK0Yukydwrgzir1BkojbJG/hKLOYHS0qZNSwi1UGgh8VJIwzmuwy/5ye0ifxuJ02RjliraerUbOC7tkw6F9aIs5FMpgfv2ZyvGh5DMXx1fMZkOMxMWnik25Fdbc5oC2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749576897; c=relaxed/simple;
	bh=jbuy+NMjRnUDwafTtQZFSseZdCd4VCHlfPBGY/vL4RY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XaohLSS828Xjd1sghKoWwo/JJXhXlbKMn7Lunso7e1/pjxqwpAnutqVsaqVbTfdv+Z4QdhZFu75qqUkjMXN/+aQIAKNrJ6A6APqfEerm4EJeKDhjG1r+PbGIqarnRQU7oS8ZCMR6+yu9piNFtNIGy4TmwSNswjRDoVW1E7Xxbk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OtLE+yTW; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OtLE+yTW"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5532a30ac41so5857176e87.0;
        Tue, 10 Jun 2025 10:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749576894; x=1750181694; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lBn8zGHwQs+gxuWFsOkiSvL8IMXsLUXM2GGRYzCDIJ4=;
        b=OtLE+yTWqNzDJCZ0TKKb3L3F4L5YHLhahRmC/HHsRiPKyqPhf/zQ+qu7dUnTUbQU7T
         BRZc5ILqE3w/6UmTEKOtZJeMFbI5uqy16lovGnEjJspCSdtiA5PG+bmPqBpYpzeJQcJP
         0pammuIlsC83akqALzFY8Llqk4WlGTf57E30eqSA6/PdEUTygvowCb1G8scx6XI4hmPW
         rgasGC25Y+++AlEFxtM1eqffY9+XFWsZ01lBrshMgrn1jBn4vz39QiFeoG9hChA/1OPl
         0gC9idfaaTlmf0TVU7Mr/+P/htTLszVRg3JeTvBzPeQb3+BVzNP4o6DP7ifttrRqU1Lz
         5liA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749576894; x=1750181694;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lBn8zGHwQs+gxuWFsOkiSvL8IMXsLUXM2GGRYzCDIJ4=;
        b=pR8PfLSvJ7AtxAkXT/rwLKY1eEgaa3YzJ7ZCpBLE7BgaTTLNbVtGBFEWiioCx+enEl
         WLJHUeX0f5504UgK/O8Uo2VKGWxaWZMn9dusZOk17ioH0v5Hc4AkQ1fe+ZZZEtrJVY2b
         DyWT2UMZ8QJJjz99XlqM/4Oeo2jVvmvPQwyzTmkPzneyZ97dkk8eNSoVcF87CiF86fPm
         xkiLUUiq0FITHRukOajm8w0sl9I1Gd6oqGNjh+59uxZmsuVZWUdTYZxKb17qsEyFXfTk
         jceXw2YfWxXTm7+prRvgvm0fsR9I+cZUP4K/A3EAhCbHlpeNmlNdOBhztTEfllbk4X/0
         pNXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsZBQ0vnLaNrC2y+oPdPihRkvQYd4eOlVEsMdygatYPleDcdoRdjZuwVxXGZ6mfCCzHTetX9s4HrQfzKA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSGtyraoo/w5E1jkhS2AvGXYOz8MZbHeAgxOZw5KOjchemwBwh
	uhSGSJ9xOis9le5SVB8+M2Y1XGFiXAHzKHk1sk03TagVVBbg1iyZ742F
X-Gm-Gg: ASbGncvNZ0QgWjDUnJMKGCpzG4Uq/HWBqHGGd/rHjtpx5+0kHaOqsbcU9wVGXg1a1oq
	k87SCPKKQBigEpXOcmstPsV2xPdpUWkHSJWwxJCeUk/DG2w/QPbk4IlEAgwA0+o7nf5NiZhHhVr
	zB6vtGA0pGpn71ouGmEt++rPt8l3XO/dQrNjXPI7ME8Yn8kwLNwOWMzrwvUWdVspzOXLPHA2p9E
	LvqqLsK0hft5Rd5XvLnSlq0GkVEMkIvrteWb5wDWZxovIKBXc41Uc/x3Cm3Gl99PyIEtz8Rw/OF
	AEi4fnn+oGdguTosfb5ryGGFA9W6fu1FWPHML/dUA53pQh+ihUnFIUk6mg==
X-Google-Smtp-Source: AGHT+IEwUeWuv+KeH++5XMInlfGM56FggBIT2kN4WEvI62lOYZl9tPVlqfi0j+IkOsLALlS4GCyVYg==
X-Received: by 2002:a05:6512:2210:b0:54b:117b:b54e with SMTP id 2adb3069b0e04-5539c289434mr120201e87.57.1749576893495;
        Tue, 10 Jun 2025 10:34:53 -0700 (PDT)
Received: from pc638.lan ([2001:9b1:d5a0:a500:2d8:61ff:fec9:d743])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55367731754sm1624829e87.200.2025.06.10.10.34.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 10:34:52 -0700 (PDT)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: "Paul E . McKenney" <paulmck@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>
Cc: RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: [PATCH 2/3] rcu: Enable rcu_normal_wake_from_gp on small systems
Date: Tue, 10 Jun 2025 19:34:49 +0200
Message-Id: <20250610173450.107293-2-urezki@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250610173450.107293-1-urezki@gmail.com>
References: <20250610173450.107293-1-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Automatically enable the rcu_normal_wake_from_gp parameter on
systems with a small number of CPUs. The activation threshold
is set to 16 CPUs.

This helps to reduce a latency of normal synchronize_rcu() API
by waking up GP-waiters earlier and decoupling synchronize_rcu()
callers from regular callback handling.

A benchmark running 64 parallel jobs invoking synchronize_rcu()
demonstrates a notable latency reduction with the setting enabled.

Latency distribution (microseconds):

<default>
 0      - 9999   : 1
 10000  - 19999  : 4
 20000  - 29999  : 399
 30000  - 39999  : 3197
 40000  - 49999  : 10428
 50000  - 59999  : 17363
 60000  - 69999  : 15529
 70000  - 79999  : 9287
 80000  - 89999  : 4249
 90000  - 99999  : 1915
 100000 - 109999 : 922
 110000 - 119999 : 390
 120000 - 129999 : 187
 ...
<default>

<rcu_normal_wake_from_gp>
 0      - 9999  : 1
 10000  - 19999 : 234
 20000  - 29999 : 6678
 30000  - 39999 : 33463
 40000  - 49999 : 20669
 50000  - 59999 : 2766
 60000  - 69999 : 183
 ...
<rcu_normal_wake_from_gp>

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/rcu/tree.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 14d4499c6fc3..c0e0b38a08dc 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1625,7 +1625,9 @@ static void rcu_sr_put_wait_head(struct llist_node *node)
 	atomic_set_release(&sr_wn->inuse, 0);
 }
 
-/* Disabled by default. */
+/* Enable rcu_normal_wake_from_gp automatically on small systems. */
+#define WAKE_FROM_GP_CPU_THRESHOLD 16
+
 static int rcu_normal_wake_from_gp;
 module_param(rcu_normal_wake_from_gp, int, 0644);
 static struct workqueue_struct *sync_wq;
@@ -4847,6 +4849,9 @@ void __init rcu_init(void)
 	sync_wq = alloc_workqueue("sync_wq", WQ_MEM_RECLAIM, 0);
 	WARN_ON(!sync_wq);
 
+	if (num_possible_cpus() <= WAKE_FROM_GP_CPU_THRESHOLD)
+		WRITE_ONCE(rcu_normal_wake_from_gp, 1);
+
 	/* Fill in default value for rcutree.qovld boot parameter. */
 	/* -After- the rcu_node ->lock fields are initialized! */
 	if (qovld < 0)
-- 
2.39.5

