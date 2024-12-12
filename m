Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDABE223336;
	Thu, 12 Dec 2024 18:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734026537; cv=none; b=dSOXJV1RSbMTwNjJh5J31a9cleYjNfzMxycBoif70rK7Jk10AiJJYgaOTtpE3Fi+58RziluuBOnzioL0l7xx0BwL8Zo0r0UDT/qzi4lx6vNif/Eg1SAOYsJ1UFQc28qJf5erCqE3p22ul9bfZWVbAtW4PENFuC+u2xFq4Eu3TJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734026537; c=relaxed/simple;
	bh=B/PSVupybPa+m8NsW6vd8W4s+YNk3hX0gUp79kCbj+4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mulEkm2SW02UuxjnfuXhhvHPm+6WfOoOhmRXMLC4/J2l2X5HM6UWJJy4mBfFnl/85NjOlA1i6i5Gw4njQcU0wUx4OEfBdwHQOWAA9B1G1bMq9cjFJlNcDB46TYa/on+oXcY+Uu0nERW4NFqE853DG4rMnmwVjkLj5W+bR0jj2No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hVYRXdtb; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hVYRXdtb"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5401bd6cdb7so931968e87.2;
        Thu, 12 Dec 2024 10:02:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734026534; x=1734631334; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d17cFn0Xubw7gH2xGZnbhSlLU5gmONRj4+qymf6is0I=;
        b=hVYRXdtbr+ps2x5n3eTmdCOB/M4S1GtmvRzHNCKV4/2sseZZfy0VeHc//GpDTzYjTs
         c4eYmV5yGXAx8QF7gzHHdPBT6JWpwIZHwIzJf+o5F4m5wm1K34Dx20vu2KOEdOvTpmJI
         y6IEHj8CHm4/0d3mwkAXICyF8/E3F5vEaXgNp/WCp1umWSv4r6+nYNDdUv2num958XAC
         Se4w4zEpd0k8Tn9lgloNdOGPmR577N/oRcysmkhoK2xOSaXLGOW4gkR47+bdeKNM3w2q
         4QGqp0R/GS42sjA9SWlECrgFTXZq567KtaTvH2HMRnYk4mW3LdV0hS6o6AngzR/p/WgN
         WViw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734026534; x=1734631334;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d17cFn0Xubw7gH2xGZnbhSlLU5gmONRj4+qymf6is0I=;
        b=LjErWQRyLQdSZ0ApT59AqO50nXfoIx996JzMq53WAlsZybNm5phxe0H5QJHsJ2DCFv
         jpIU1MA2aiGA6DotGQS0Hd0+dl9OUhJYAM48B0zLec2AhlEEq0380fKd7cj/9czao39o
         P8D+PKENyvoSH9qxdpWwNQKhafk55gwCX6bl2iUrJi/RGUJAc0BJcN372XB5b+t1DgVn
         RsCkYHXiOiq59B2qGCge4sjV0ForhJL3Sj2dcUkcuupFogcc5JeyjaLN0c0699zsPDj4
         Bf170C89ybtRGVn0NgG7LNnJWmPwxizwvnC72dCuYcDeZLa/V20AoyQUqkKIrPl+1QtX
         vAwA==
X-Forwarded-Encrypted: i=1; AJvYcCWyt3ncAi2VBtUNB5YTDcNduIFwJhxogkGyrhUByki2yIzdhYeikwDT+vWd7d8M5yYWBLX2Bi5ge94YyxE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhVy51kmXY8EVan2Cw88ut9b28cDpq8vmknik1NcXmUzSohKMR
	CDEokAliUNC7Sl8sxRr/w/5rjywQTr3+E61D5PmoTh4BKCfvMckz
X-Gm-Gg: ASbGncvxCKrxFtkXw6m5HzadMDcTjkhVLpnNtCNlU89cPUx+ChKXyjqukXxXi3f/C91
	YI3gEfYWPFVqW3ghDev8h+gylNF8RKIcoxu587uvEbHICyRkPocMUNI9Tnanrk0Z/L6ta2aOG7a
	iplyIulNUxZgC6g++O2crk76P/G4S3NTJeGgH49lT58QN779+rhvv6wqNqMmNWokUW9MAuNOETN
	qM2tv39OENOleynZChE1AxnFqPeEJqja4I6EhNRGwrpwsXBuymb
X-Google-Smtp-Source: AGHT+IGz+p8q2ObIoPlvWL19tlssMjhRoDnjX+5PLTP5UDSV8wGIYh9EGxkPINPkkiRjxhnvXpmUGQ==
X-Received: by 2002:a05:6512:3995:b0:53e:3a7c:c0b5 with SMTP id 2adb3069b0e04-54034100d67mr608345e87.10.1734026532195;
        Thu, 12 Dec 2024 10:02:12 -0800 (PST)
Received: from pc638.lan ([2001:9b1:d5a0:a500:2d8:61ff:fec9:d743])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53e39375d36sm1940645e87.7.2024.12.12.10.02.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 10:02:11 -0800 (PST)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: linux-mm@kvack.org,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>
Cc: RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Christoph Lameter <cl@linux.com>,
	Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: [PATCH v2 1/5] rcu/kvfree: Initialize kvfree_rcu() separately
Date: Thu, 12 Dec 2024 19:02:04 +0100
Message-Id: <20241212180208.274813-2-urezki@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241212180208.274813-1-urezki@gmail.com>
References: <20241212180208.274813-1-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a separate initialization of kvfree_rcu() functionality.
For such purpose a kfree_rcu_batch_init() is renamed to a kvfree_rcu_init()
and it is invoked from the main.c right after rcu_init() is done.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 include/linux/rcupdate.h | 1 +
 init/main.c              | 1 +
 kernel/rcu/tree.c        | 3 +--
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 48e5c03df1dd..acb0095b4dbe 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -118,6 +118,7 @@ static inline void call_rcu_hurry(struct rcu_head *head, rcu_callback_t func)
 
 /* Internal to kernel */
 void rcu_init(void);
+void __init kvfree_rcu_init(void);
 extern int rcu_scheduler_active;
 void rcu_sched_clock_irq(int user);
 
diff --git a/init/main.c b/init/main.c
index 00fac1170294..893cb77aef22 100644
--- a/init/main.c
+++ b/init/main.c
@@ -992,6 +992,7 @@ void start_kernel(void)
 	workqueue_init_early();
 
 	rcu_init();
+	kvfree_rcu_init();
 
 	/* Trace events are available after this */
 	trace_init();
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index ff98233d4aa5..e69b867de8ef 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -5648,7 +5648,7 @@ static void __init rcu_dump_rcu_node_tree(void)
 
 struct workqueue_struct *rcu_gp_wq;
 
-static void __init kfree_rcu_batch_init(void)
+void __init kvfree_rcu_init(void)
 {
 	int cpu;
 	int i, j;
@@ -5703,7 +5703,6 @@ void __init rcu_init(void)
 
 	rcu_early_boot_tests();
 
-	kfree_rcu_batch_init();
 	rcu_bootup_announce();
 	sanitize_kthread_prio();
 	rcu_init_geometry();
-- 
2.39.5

