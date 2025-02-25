Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34A4267F62;
	Tue, 25 Feb 2025 11:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740481228; cv=none; b=pFaUCS4Q22DZGlLSsWR1DHsf86wR/PehjNJc4BZC6NpJbTQb470Y3udpQ/53dwfWKcESZsuhqOy6GGtnbyEhjRTAa4NN8qml+ADt3ltEzh7K5ms7kexkFXQpYe+Kt9WmGXt4WUy3JOljy4WzSGsOgDCPBQNueYYVHWMdMqyw7AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740481228; c=relaxed/simple;
	bh=4LvdbPCYHfIEA9VMVlfoNGibN70QZsOBdBupKny+JlM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P+eKNufaVAlNDdTgYwH/E9phkbmaA9ccCk59gnfSNsw9G0P/Sfw+pLE+Sa/Qtm/4bXj8NTf10Tk8XOuQu9JGjfgQ37AZ4gElpDxDQ8Szhm1xP2+KaU3nfLi6uVhnfiTUOaqkMYA2BrnENduE/Y8ktuviJI4S9W+XB4HmKXoNhRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m4wBJ6Kp; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m4wBJ6Kp"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-546210287c1so5581725e87.2;
        Tue, 25 Feb 2025 03:00:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740481225; x=1741086025; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rniMvaYIi26adKpEqcx0hyA8jOwUTjRcY3RJP/H9jWw=;
        b=m4wBJ6KpddcjyHTF1/czgbvXQ8ipvZdPtVh9OLxqWCrFIHArHNzeexEvdnhc9qOAH8
         eVKAY6ZB+bx7ssg53Tea3/oAPckfHTQBXSzolb0lA9lGhFsDlr8IRESeg3jJ05ggZ40+
         avmYsXFRGmZV4A3I2wuoFd4R6iJRsqPLk+jf8g20rYX4l/RpZqsP3db00fUnBt0w7JAo
         Dof0YZQ28eT2wXRj+XdL1jX/L9COeYg96U4tRwVDSGbB0KmD9KblxqSwwf3k7F2VB2j8
         TZmc6mXwA+IPv0GPiFYeox4kmzlwt5YHUxnMoLzjuASy0jty93kc+Wpts26hzLH15tHr
         Kx1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740481225; x=1741086025;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rniMvaYIi26adKpEqcx0hyA8jOwUTjRcY3RJP/H9jWw=;
        b=QI7daNxEl3NjMM22yaFCxLkJXVtVQ9DbEn5XKIRAtNrVDsrLH6VgGFaepf/METzkR4
         io1Jouln+D8A4d0slgWCfRrYm9qM4vU3rUOcEhG34bR/XN2p4Ri1AlID0dts1mUrNbzk
         KYy/TWA8vi0qORbH/LF83FGbDBYgjFi8vM9QVgzFdkdgVTU/GCTTG1y/SP+yYfBwdTyl
         6pzcuDu5yoVn3uBXF0qwZ3+WqBCSs09ncDjC9fjdJDACCRyyPG3TMWQRP5fU/tz2vAxW
         k8xEFyI9zSFiM5FyHU7TP29tDQT47a3EM4gk+9lHqmWilj8LzfH4fJcHXxzJSLmLHxmC
         jPuw==
X-Forwarded-Encrypted: i=1; AJvYcCVEVVk6eXHYq/S0Ulg7hzFXN74Z8pb0IfVnU8cUIy8ZeC2dGnNzdy2xP1AWQQvk1QfUegR/vlYcbW4CdVw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLC/O/hHlCZ+V3hh/LZX9UVn+/l3A0rXjJ043SCbDqF8fOMPTX
	+Uj2DcElh06d3vhJmOVq0Wg2/Bt/KrEuXxUdgkjjiqUssX1L7ZP+
X-Gm-Gg: ASbGncss0RefhknDxo3bn9VzbFbCDUSX9O6LeQKtDclIIXOWsf7mihwFeDEHG+bM4MB
	9iXbPPYzxg4zElXMz5Hdc+2bH0NA3YgF/t80RtCGBtCQR7s3dNtQqiMVGmFWCyAqtNsUPf8b7MD
	vADp6EytliyxvPr9EUaRzNIszj/sa60qKkoNGaezWzvRmp8trvTnYtatBWT4XKOj97C8Jdr79Ty
	qrfkKEP5fPty+hgXC4qjnTjdAzRUQOajn7IC43TW15GxP0NgiJMYm5J3XT8Rfpal7VXr8+ZkVBu
	I/Vbb44EZLemMVlZmw+8sQ==
X-Google-Smtp-Source: AGHT+IFsvQXrb22vLgRYUoiA2ph8/sr59XjDMExdY1gmmRC6ZweDxkH7vhPkJt6W41kay8eJlK//cA==
X-Received: by 2002:a05:6512:3a89:b0:545:2a96:34fc with SMTP id 2adb3069b0e04-5483914820dmr7023064e87.31.1740481224332;
        Tue, 25 Feb 2025 03:00:24 -0800 (PST)
Received: from pc638.lan ([2001:9b1:d5a0:a500:2d8:61ff:fec9:d743])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-548514b9886sm143850e87.71.2025.02.25.03.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 03:00:23 -0800 (PST)
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
Subject: [PATCH v3 3/3] rcu: Use _full() API to debug synchronize_rcu()
Date: Tue, 25 Feb 2025 12:00:20 +0100
Message-Id: <20250225110020.59221-3-urezki@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250225110020.59221-1-urezki@gmail.com>
References: <20250225110020.59221-1-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Switch for using of get_state_synchronize_rcu_full() and
poll_state_synchronize_rcu_full() pair for debug a normal
synchronize_rcu() call.

Just using "not" full APIs to identify if a grace period
is passed or not might lead to a false kernel splat.

Link: https://lore.kernel.org/lkml/Z5ikQeVmVdsWQrdD@pc636/T/
Fixes: 988f569ae041 ("rcu: Reduce synchronize_rcu() latency")
Reported-by: cheung wall <zzqq0103.hey@gmail.com>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 include/linux/rcupdate_wait.h | 3 +++
 kernel/rcu/tree.c             | 8 +++-----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/include/linux/rcupdate_wait.h b/include/linux/rcupdate_wait.h
index f9bed3d3f78d..4c92d4291cce 100644
--- a/include/linux/rcupdate_wait.h
+++ b/include/linux/rcupdate_wait.h
@@ -16,6 +16,9 @@
 struct rcu_synchronize {
 	struct rcu_head head;
 	struct completion completion;
+
+	/* This is for debugging. */
+	struct rcu_gp_oldstate oldstate;
 };
 void wakeme_after_rcu(struct rcu_head *head);
 
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 8625f616c65a..48384fa2eaeb 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1632,12 +1632,10 @@ static void rcu_sr_normal_complete(struct llist_node *node)
 {
 	struct rcu_synchronize *rs = container_of(
 		(struct rcu_head *) node, struct rcu_synchronize, head);
-	unsigned long oldstate = (unsigned long) rs->head.func;
 
 	WARN_ONCE(IS_ENABLED(CONFIG_PROVE_RCU) &&
-		!poll_state_synchronize_rcu(oldstate),
-		"A full grace period is not passed yet: %lu",
-		rcu_seq_diff(get_state_synchronize_rcu(), oldstate));
+		!poll_state_synchronize_rcu_full(&rs->oldstate),
+		"A full grace period is not passed yet!\n");
 
 	/* Finally. */
 	complete(&rs->completion);
@@ -3247,7 +3245,7 @@ static void synchronize_rcu_normal(void)
 	 * snapshot before adding a request.
 	 */
 	if (IS_ENABLED(CONFIG_PROVE_RCU))
-		rs.head.func = (void *) get_state_synchronize_rcu();
+		get_state_synchronize_rcu_full(&rs.oldstate);
 
 	rcu_sr_normal_add_req(&rs);
 
-- 
2.39.5

