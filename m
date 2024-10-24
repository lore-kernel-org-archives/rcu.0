Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F632165EED;
	Thu, 24 Oct 2024 16:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729788365; cv=none; b=pYldYNKzUS/8rcYEQY49WXlrbCoF4A7uW086wELJN+95Okcpur/6NWDv2hJoQ7msgwnIdBKMTGd9hEw11oi2F9qhne5DMyM3C8a5xjSYle0R55GZkFkGumWlDk69TX7JFHORdweqRqxjJMVqLuolmhEnBxa+T/bLg1bMrpVjLak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729788365; c=relaxed/simple;
	bh=Is6IxtGKopNqMggJI3+uU+jdeuDQaDroFVVGumkgW0Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LR/8K6a+pr/UwrlJhW8lqmnv+WrY48XV8H36kdcNrh5xQeVZehkGCHHozTl9/26F2VmGZWVe9DF93yOZxWvA326+NCvJ71sM8CzUCqSwKqkI8bEqu8rXmEcObJttKuXzWiY/vjwTl3mG3tEnkWr4ZOxF1sKNBc8X+cxpOzB9hBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GlbHXETY; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GlbHXETY"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-539e59dadebso1472932e87.0;
        Thu, 24 Oct 2024 09:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729788362; x=1730393162; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YsBke+mJeOyoHifHQPp/Ieoz+HxT6aaDZELqx+rqKnA=;
        b=GlbHXETYzctyagMKGWSq2wMwVLUDREFu+aN1OqCvNDb6Xp9uLfnnGVDfWHJULMkauT
         LFqamEwIjnkMxAsQxdGlNeuJydrt/N+bHOrAtJA2RSwPCeLCgV2xq9vFS4QYH2679iu5
         WuR1/D/rX88iXcmfjFM0q30Ts4slmbDCmyRxqfGZBsRA5nVWF1KOIaG6bSjm4Ar2R/DH
         I4937mqb+CNxRBlHVfnPp4lS4KNIOF/PyvDj42lhYygMZSv8z5kJ/tWTxIQG4SRvn1WW
         RGVTb6Z+mWQ6mxBxxKiegaNU2/Q6nMFsItQLzt7mVp1NcDxClKjaqG783UB3aYtu3bZT
         N8tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729788362; x=1730393162;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YsBke+mJeOyoHifHQPp/Ieoz+HxT6aaDZELqx+rqKnA=;
        b=RAHZxHOu8o+vzjWlVRukwKAmnfwYFCdvxcsCn2TcfZtQpRyugIt6f0vLlD6QYagZeM
         r79mC6t+hYE6ksLDRwfHqhotDK6NvWtlI4KTsYOMq7RLgifidgIZUx9AD9p0jQ4qypoC
         FM9GvlIQodLBTLyOw9CqsqJeU3wbT3LAIyAp8m5de1yRoKIt6Pt6OKb9m4SOuXcxEnDh
         7LWqWd5HhMqarrhb4BO0joqLjx5H5xBlZlbr/MQRSPIzf/+NtkfXQOOF36ePR2fB12cV
         Lp4X/uoINJnP5AFArXd94wmkgXzlzFLuBDqkEIcM33UBl9GpCXSnWYKMt5+TxpaYx39G
         f7mg==
X-Forwarded-Encrypted: i=1; AJvYcCU8fiDA0k0pAyXIHDfUOBumBNJEu8KZPqgn+3Nx3Hew9ao+B3WKhbMSNub4mAmsW2xeXZE2@vger.kernel.org, AJvYcCVGSp6yILH8dq44WHP2E8JpMaRKJiwOTOXQfId8lHSshA/2wkQZqXFhLWqfU6gh5qkKoxMEAfYAj+lSP/c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGQbdnglCtymhasx1KJ/CvJffyaueXrt0QsXs3KGMu/Z+YZQQu
	bxKBi6O3gOIv1EwYNiZX8fLCk4nXpP6wjDXWfndqhlmR5rEoPNZcFNoytQ==
X-Google-Smtp-Source: AGHT+IFD2sJ9uVvKTHvenBc2PiHq58VJ76LKA3sFYB85lxmgVI/FHojbRVRB6aG1TMgiLyMT1Esx1A==
X-Received: by 2002:a05:6512:4023:b0:539:e65a:8a71 with SMTP id 2adb3069b0e04-53b23e2d5b2mr1658461e87.34.1729788361322;
        Thu, 24 Oct 2024 09:46:01 -0700 (PDT)
Received: from pc638.lan ([2001:9b1:d5a0:a500:2d8:61ff:fec9:d743])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53b1f2d17b5sm441967e87.22.2024.10.24.09.46.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 09:46:00 -0700 (PDT)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: "Paul E . McKenney" <paulmck@kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: [PATCH 2/2] rcuscale: Remove redundant WARN_ON_ONCE() splat
Date: Thu, 24 Oct 2024 18:45:58 +0200
Message-Id: <20241024164558.715296-2-urezki@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241024164558.715296-1-urezki@gmail.com>
References: <20241024164558.715296-1-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are two places where WARN_ON_ONCE() is called two times
in the error paths. One which is encapsulated into if() condition
and another one, which is unnecessary, is placed in the brackets.

Remove an extra WARN_ON_ONCE() splat which is in brackets.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/rcu/rcuscale.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
index de7d511e6be4..1d8bb603c289 100644
--- a/kernel/rcu/rcuscale.c
+++ b/kernel/rcu/rcuscale.c
@@ -889,13 +889,11 @@ kfree_scale_init(void)
 
 		if (WARN_ON_ONCE(jiffies_at_lazy_cb - jif_start < 2 * HZ)) {
 			pr_alert("ERROR: call_rcu() CBs are not being lazy as expected!\n");
-			WARN_ON_ONCE(1);
 			goto unwind;
 		}
 
 		if (WARN_ON_ONCE(jiffies_at_lazy_cb - jif_start > 3 * HZ)) {
 			pr_alert("ERROR: call_rcu() CBs are being too lazy!\n");
-			WARN_ON_ONCE(1);
 			goto unwind;
 		}
 	}
-- 
2.39.5

