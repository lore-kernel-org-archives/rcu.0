Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C9B15B96E;
	Wed, 28 Aug 2024 11:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724843376; cv=none; b=D99WNJL33GVngu1JF7XD1iM+HQq1fRrF2FdjVQH58Vf+wJvyuauDD6E19hV9Ikr6/apKt5SnqNhuJCfgwSWqY/BEx8QBlEiiuMNzbhgO5JWIz956U51BCD7dH+2fgRwDHu1Xlm4L9xNkwRqrhi7aPWBtAQhF/thTRvEYklUnpsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724843376; c=relaxed/simple;
	bh=rJJSGflVEsvyegqM2xzslX9R1V3V8wlyxq1WlJTXKyw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fc9FRzake8S+1Fq1jgNhlarxNDpyXLxoKkq8uO8NPcqziqTbxVos3rfwmin+jTZcI6Le3c5YU2/xQkuQqigo5xIQKGPKrT0LOn8VFaOCa/IWDjjUebD3bTwRkhY8/i0QpQk+3/66T1d/HFhfkxDIrAQK4icQZV5xSr/DuzpzYtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ghjv7ONl; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ghjv7ONl"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5343617fdddso9877002e87.0;
        Wed, 28 Aug 2024 04:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724843373; x=1725448173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Qxc5i9kYwybQ5di4V7uU+5XJm5+s4ugo63m8+R6Bkc=;
        b=Ghjv7ONl0L2b6BZAbBRQS1lTBrDYRn5Lsx0KeYNeaa5ZzRu2KcYBSJxeDp0YIpVsPr
         lUT48QDreL4rkHnTZwrTDJ7ursZ4920kBcPT0XncVM7RmvhnrbgQyLCiapT+e9OsVPX5
         rnIqaa9TP1rHWub+IbK/Idyauf1JN4vT8C5Cl6OEjj6XoeqP+q97G+PEMM2ykAUkVedE
         NCAjYKQAmNGEXj9Esmmp6B608Ws+W/tzIG7fBMCyBlE57+AxyhDbD40OIP6m/bwm7I+f
         y3KpWAcjyDhJRY4FXShqfNpHlUaG/wghXuK8qJlgETti4Hvbg/hI38F9+T+gOZ39DCTF
         Wsfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724843373; x=1725448173;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Qxc5i9kYwybQ5di4V7uU+5XJm5+s4ugo63m8+R6Bkc=;
        b=deL4TjLzbXe1EbkcvthH8RFaFuQjv5PGSVZiVa55QIaTD/AJXJucoVdtTwcaG3mY4W
         k0l4daIZ2AS8m3w3aeyDJ/TLj/WhW1DtQYA9CO/UHT4kRRfD8xvNJkdY69GeiAj2iXgO
         QKnfNz5J0+Erjn/Zf3Kl1UFNhRH0wXjKR/4MV09WJlQ6kV1wc2201mHGaJjcbAw8PfDS
         YbbdpLN3htqM1vbfWrhNabEEVEO3Wa+4OQ3fkwcoKMRaLIb4vzH1b9GzxBSX+IZEsLZX
         VHfj3g2KaxQv2NKQtAjAzG3X2JV3/Cb8GkQKLFFEboUW9vWgGUdHou34lJ9rbvKv/O27
         J5dw==
X-Forwarded-Encrypted: i=1; AJvYcCXRenSHkmeOVi+5ez3s3kUCsnoXzNtCPD96v3uOeGuutmEJtf6wK0yeXU0MGGkU0a/xQp9I30fuRvDTwos=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywnnl9qwseG4pe/geD+HsuzeGsQxgajwE6Q3Sezqqln/xQh+kfC
	vELYlGaQHt2ID8hlf5i3Va5FDQmuD6bcSEa7d3M2x01yaoVZtzrugLh4GQ==
X-Google-Smtp-Source: AGHT+IF1Jz16avNF0tBfsqqNv73DT3YAtTjwrKxBCnHISd7IwnrF5cCs3LhuWbZOlMsZJ+2wtXek/w==
X-Received: by 2002:a05:6512:2243:b0:52c:e091:66e4 with SMTP id 2adb3069b0e04-5343887e244mr13519428e87.44.1724843371945;
        Wed, 28 Aug 2024 04:09:31 -0700 (PDT)
Received: from pc638.lan (84-217-131-213.customers.ownit.se. [84.217.131.213])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5334ea5d6bdsm2154922e87.208.2024.08.28.04.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 04:09:31 -0700 (PDT)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: "Paul E . McKenney" <paulmck@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>
Cc: RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: [PATCH 2/4] rcu/kvfree: Add a switcher for dynamic rcu_head
Date: Wed, 28 Aug 2024 13:09:27 +0200
Message-Id: <20240828110929.3713-2-urezki@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240828110929.3713-1-urezki@gmail.com>
References: <20240828110929.3713-1-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a sysfs attribute to control whether a dynamically
rcu_head should be attached or not. It can be controlled
via "/sys/module/rcutree/parameters/use_dyn_rcu_head".

By default it is OFF.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/rcu/tree.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 0124411fecfb..893ee69d4a4b 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -206,6 +206,9 @@ module_param(rcu_min_cached_objs, int, 0444);
 static int rcu_delay_page_cache_fill_msec = 5000;
 module_param(rcu_delay_page_cache_fill_msec, int, 0444);
 
+static bool use_dyn_rcu_head __read_mostly;
+module_param(use_dyn_rcu_head, bool, 0444);
+
 /* Retrieve RCU kthreads priority for rcutorture */
 int rcu_get_gp_kthreads_prio(void)
 {
@@ -3814,6 +3817,9 @@ attach_rcu_head_to_object(void *obj)
 {
 	struct dyn_rcu_head *rhp;
 
+	if (!use_dyn_rcu_head)
+		return NULL;
+
 	rhp = kmalloc(sizeof(struct dyn_rcu_head), GFP_KERNEL |
 		__GFP_NORETRY | __GFP_NOMEMALLOC | __GFP_NOWARN);
 
-- 
2.39.2

