Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BC42D0C85;
	Wed,  2 Jul 2025 14:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751468387; cv=none; b=Mmm3VnBnquKXQ0vRQ+Ri8yRxWQfoflUZL4+HGFQ/wng1nTWjWUyriLg0cLV736Q01XUQ7sHsJAb8cbgBgUfliBogreV90Pi/zMpBsT6pqb6P+zBkKyBXXDm7oOARDckGTY6w5T7nUM/zV6ht/QU4KubTaNCLyC9RoZ7+Ck8Y+p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751468387; c=relaxed/simple;
	bh=9665KWXzUAe95N3DvaTz9p80eeYQf0mH3BxIHQ3nnzk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lzETyBPqofucwCy8B9KICZw2CeZg/eL/2kp8alSsJPByBtfW9bHk5Ypy5t83O7NoycB6ltgNeF1gHKghmOjYxFXKlRmcBGWzauolsefCqUtho6Y4qAVdpSzAkaPsM3JK3vHtRKQl3YA2ahV00IbA4W5Nu+hCHdNp7KLrcbjb7cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BTcLK6V4; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BTcLK6V4"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-553bcf41440so7204313e87.3;
        Wed, 02 Jul 2025 07:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751468384; x=1752073184; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AgAxCMIrNojBqyi7PLDSP8jysiE5JFxuh4gLazl9t48=;
        b=BTcLK6V4sNjzFzPfjmLl60cYZT6DY4iD4SOOxZ92TsTgPwq8MHGdTCav4Sije11rAP
         hGsZ3M37y6ixJUAsdy/3JaQxQcT5N7WuLJwJ7Z8rSlij/RJn9qYJYkdfJT4AjwH+grBz
         iq01xT8iyvNdpU+9BBWa7uolCuUsuykFqoSlJgsJfY4RhJNL+SEjCB89n08+SNbyyzLQ
         /GKkCRgsKLKh2Im7tjshgc+1MlRXlbqQ+PacQm+raRww9edeGgEIi+Zc/0FCb4/7eCPr
         Q1CGDBlKEo3YhzXDL8S+3OTKB3eM9FIde7sDLlYB777uC0IN02FFdtw0MptOuR3RU9mz
         z5pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751468384; x=1752073184;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AgAxCMIrNojBqyi7PLDSP8jysiE5JFxuh4gLazl9t48=;
        b=WadpUPzVUBdUhWETIVa0g71B8uC+QofCXtv4RP7W68JaleWb7r+4oBjdgQjReDVL/n
         ukoF/HjAK0sRvXrxQTUM9vpwcbgulyxv+lGjnMt/okcwg5uCkkkmUuJ3g7IofxlfGX6X
         QAqIcCM6rGryeSW2jus2EQIH016bsuqbTJXgbR2rXl2RRQkZKcSPtlV05lude1etB8+U
         lNnKhxi5i4DJa7Y89DUZ61bKJ9byKg/c6IHr2JOIQyipfI18a0kKA3BrJyQIVzr8NsU2
         7Es2tVH2j3jCG7Syrt6b+50Th2satxWheYAZK+E+1TjZJiO70AYUYVbkXRMb87PANcDc
         8gAw==
X-Forwarded-Encrypted: i=1; AJvYcCVgb0PdiDj50ER6mz9Bm04oIfTu9FEhgZQ86cpfX1Eds7rANMmxd97JF8mWIm/mYaDjwp3L0z/70a5lrjc=@vger.kernel.org, AJvYcCXTRYl9LYIqqQ7GzU/kPDGnNCKKPw4sASbdzmD5ACwGcksLy+LPfGVpjFnyqtoWK1vuoO/8@vger.kernel.org
X-Gm-Message-State: AOJu0YzpsnpTn6FUW7PmBZzsKY2Z6JmQ4zc/eOSjC0s2TPfjcMMKoqun
	00QQNtw/pe3W1F40MA7IQZrT/CG7bmEcl0VGnk+lytPR6IkQ8JzWQ9H1
X-Gm-Gg: ASbGncvjWQjONk3eXAqEZS+hoLhQZ+Eqmw2zdibCP4XpIx330v7lSw1bHLzqWqKoHqx
	poIMRn4+1coWJ5ZUxBGD2H2Ky9KXzJpLwiU1q+IlCJfW0SElEpcvt3nTlX5IESEQkcXe5ygEQB9
	DPZWmVaIRUArZWzPDdTn0X/IyFJbe1FT5zMJox3M8TGsOpHwXPt1ZiPFVNNNyYpAW3vWvfa8LMw
	5vRq6CvvqXKvZRxikrSeUQbgjK1JU/x4hkiUVgPbuB55UQz2JxZ9B4/HTkBkupnOlqGxGkLICF9
	2OMYqNrBHUyDrQTIrz2W2X78Ys3bJm72Y86LaZjwCWf0zO0G4wdvFsPmmw==
X-Google-Smtp-Source: AGHT+IGWtJUxsEyC4A2J/bOZNg1wTbT+dGpxuRahEtSl7lFFe6BDTtUxvZnOrwHQ4KzLFzgugQLk/w==
X-Received: by 2002:a05:6512:2353:b0:553:d122:f904 with SMTP id 2adb3069b0e04-55628258330mr1185503e87.23.1751468383689;
        Wed, 02 Jul 2025 07:59:43 -0700 (PDT)
Received: from pc638.lan ([2001:9b1:d5a0:a500:2d8:61ff:fec9:d743])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5550b24010esm2166907e87.50.2025.07.02.07.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 07:59:42 -0700 (PDT)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: "Paul E . McKenney" <paulmck@kernel.org>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>
Cc: Joel Fernandes <joel@joelfernandes.org>,
	RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Joel Fernandes <joelagnelf@nvidia.com>
Subject: [PATCH v3 2/2] Documentation/kernel-parameters: Update rcu_normal_wake_from_gp doc
Date: Wed,  2 Jul 2025 16:59:37 +0200
Message-Id: <20250702145938.66459-2-urezki@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250702145938.66459-1-urezki@gmail.com>
References: <20250702145938.66459-1-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update the documentation about rcu_normal_wake_from_gp parameter.

Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index f1f2c0874da9..f7e4bee2b823 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5485,7 +5485,8 @@
 			echo 1 > /sys/module/rcutree/parameters/rcu_normal_wake_from_gp
 			or pass a boot parameter "rcutree.rcu_normal_wake_from_gp=1"
 
-			Default is 0.
+			Default is 1 if num_possible_cpus() <= 16 and it is not explicitly
+			disabled by the boot parameter passing 0.
 
 	rcuscale.gp_async= [KNL]
 			Measure performance of asynchronous
-- 
2.39.5

