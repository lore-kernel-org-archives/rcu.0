Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29FA2165EA;
	Tue, 10 Jun 2025 17:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749576896; cv=none; b=pkj7frSaq19MVkSBNaJU9dODA3aly8uew3ln8oUS2IBxGw9SnLldk0rjsd5ClMCj7eLddsHLauMZPWcrn68YLyz9ObdLrg8kDFNNcaTz5rBdi2rR6hYfiy/luMtdYKHpp80yxd3viE/yvNF579/IiFWDu6IdZbeQVmyQVi0vefY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749576896; c=relaxed/simple;
	bh=ZIHQmbd8mZW/I/J4s7YLgy9S3Trx9A/+7wpfB+SmC34=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZeGGdQerPBNfD1gAKKofIwzZLtz8Fq8UQFFDlUiSSlyT/K3BrF2p/FAJq2SqAAFL4YUr9Lx45zwFvW6rCbBQVZE6HQ1Ok2sxIMBJ977NVmZ8OCE8in0jZdcLgW3x+kpFILU0shASd1a+U/ZYghr7Sa5Qm1Z78nwor7gkwqJAYAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=caz7KHHp; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="caz7KHHp"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-55365c63fa5so4921213e87.1;
        Tue, 10 Jun 2025 10:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749576893; x=1750181693; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NZ0SzQALZKWzXSc+j3nisP3t6uYxEq3fuujkS0uppSQ=;
        b=caz7KHHpK3WUADI+7FK8XuGkOfTd4ebK1LPaQg+YXT7U9VXxNhhPK0GwJB46puBaNj
         fWcgnZMrRcmQxovnlDwqgXMEVAZc42AEWb3q5mtOQ/eeRX0KVTvKipIepGxExXBD75lh
         Utx57ubuoB8Ocsn+emcEjfoP09mgg59wTnaqlmpk6QxfD4jK9xuvjbSr1Us0v74+Gc/U
         qhEogk8a1Wi26zNducD5KjJ588RsZf3y3gX/lVnMraBeDzWYeI1+57Fyh1gvl34MY+2x
         /Vt6EUjjLdUUEde7WlsCKBggWkBzobIvnp/GH9pRgBZdpXGPXd0g8nYzExc+s8v4Zmz9
         H/7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749576893; x=1750181693;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NZ0SzQALZKWzXSc+j3nisP3t6uYxEq3fuujkS0uppSQ=;
        b=phA8NG0iQlXdr2zeOiRq/+nG4Ky4PLE+u1t6TUxKYwr1c63qewT6bthoNAeKt8pKLe
         5yrYTgYYXiM9pNgqoQWvqhms1xKC1RD5LmVBVvUXWmcpSdsPzeEt3AqW8Nz2KLPBtD8A
         6BQmjvAGFaNK6kWGzrna2bzztX/YLbOOAQK/U1qhvEdzQufF/0b7e2ScPuInySk++3HT
         3iZVuve5bzFMOa7c+VBogWsAnaj2wYe5K6vVbNlg9sSuJbLy2zHdOb+bzxwyBqipVJoG
         5VA1n1yKcVmSG9CrTmxKj2E6Ae+DkTWYVzM84wnrmJfzLYuAqodTjmmu0QEo095cjCXH
         yjbw==
X-Forwarded-Encrypted: i=1; AJvYcCXmCLDV3NFzLWXA9c2owR29T6r+KyETo6gh5Bn+euQ7YLGR2AtYVNDrB6rUGr7WFGbuL83H5OYDeQB9M2Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxpa18q9MGxvlMVSP6xq4Ir0a8zQSpXhYCzEsyILt+NKLi6mPVZ
	U34GDwLHsLIl4H0lqmSn0RXKUXMIA7qqyK9ppj3ipmC0IrerP3Zpdygt
X-Gm-Gg: ASbGncvN1UbT2MBpeeweBMo1gsVx9WRA58XQFUreR/y+TPuX3gBB6G/IWACWPNBI17K
	oGlKLl1zpir3ZBFNaGpmxm5GrnV8YctITPU/MpkHA2f3vra/NPnZageBnG3qJtpabKOvR1VEt2D
	nXMPcNV1D1AyYxbwd8zLSN3WFeLnH+eFrGjFHZMKgt3lfiwdNWNZM9caXWvuh95hdVbdBYTGOBs
	2TGcvM8fozfQh4/hBJQkKtWVc6ai6iz/DM6n86OLR/SIy7LlgZ6asetEZQAwBrLVdAFJ1AuvWTN
	d41Vnd86UfXd2NxGlS7kDBn4R4H/SUVJyWpFhABK4JRrRWFLmTeMOyI9Dg==
X-Google-Smtp-Source: AGHT+IEIUZWuFvLl2tLbz436lvIGIGwbpfPHMMh2XT0YfPCYJ3IXj9T/0u0E1d+Dys/s+FLY9tFbrg==
X-Received: by 2002:a05:6512:6d5:b0:553:2cfe:9f1f with SMTP id 2adb3069b0e04-5539c106f7amr173900e87.6.1749576892565;
        Tue, 10 Jun 2025 10:34:52 -0700 (PDT)
Received: from pc638.lan ([2001:9b1:d5a0:a500:2d8:61ff:fec9:d743])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55367731754sm1624829e87.200.2025.06.10.10.34.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 10:34:51 -0700 (PDT)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: "Paul E . McKenney" <paulmck@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>
Cc: RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: [PATCH 1/3] rcu: Return early if callback is not specified
Date: Tue, 10 Jun 2025 19:34:48 +0200
Message-Id: <20250610173450.107293-1-urezki@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently the call_rcu() API does not check whether a callback
pointer is NULL. If NULL is passed, rcu_core() will try to invoke
it, resulting in NULL pointer dereference and a kernel crash.

To prevent this and improve debuggability, this patch adds a check
for NULL and emits a kernel stack trace to help identify a faulty
caller.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/rcu/tree.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index e8a4b720d7d2..14d4499c6fc3 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3072,6 +3072,10 @@ __call_rcu_common(struct rcu_head *head, rcu_callback_t func, bool lazy_in)
 	/* Misaligned rcu_head! */
 	WARN_ON_ONCE((unsigned long)head & (sizeof(void *) - 1));
 
+	/* Avoid NULL dereference if callback is NULL. */
+	if (WARN_ON_ONCE(!func))
+		return;
+
 	if (debug_rcu_head_queue(head)) {
 		/*
 		 * Probable double call_rcu(), so leak the callback.
-- 
2.39.5

