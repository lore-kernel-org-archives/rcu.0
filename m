Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E76516F858;
	Thu, 23 Jan 2025 18:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737658715; cv=none; b=NodwM5p7RD7ZHZqecZIKU0ruMtD17zHdEXILmuw29+pyBE9o1LzpjgbxQa9DWPTi1eiLW+Z/CKT0Sjrham8FWJ0dRvZCyEfcxL6eef1gHvZwdWbRd+phxUxZl4IeubDjcHRgMr87M6vQylBG1aYdiYS3qflQw7IBDp2NWAGay1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737658715; c=relaxed/simple;
	bh=huvA0Eqmf5vb3szR3jUX+yxvj+JUOxupUW3Bf9sh2ys=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TglDE5JDF7MRZzYpC+76Q90YeHqO4Mcym1TJ3OibWIPlNdwBvFg6Zdpglcuff8zu4+YfSBqiekbR8SlpRXgW9a9urF9Oy3GycA5ALqar4rn9HnKok6UlxE95M2BpsJAW7y4rJXcADqrZlsgzrMTrXKgpIY0CEg6JqbtWj2Abo84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fhb+9O0V; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fhb+9O0V"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-3002c324e7eso10823921fa.3;
        Thu, 23 Jan 2025 10:58:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737658712; x=1738263512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sVvT7NP9aO9EIv6Tv5VTAY7tEo9/tNIuoTqsrg0VSvk=;
        b=fhb+9O0Vd6YpE1Ob9kKXN+2LOPc9SVLM+PC/cR+GUXKYvTksyX2iWRk9gR+iDGOi9+
         RiVfQ5cRDcQJ8ESOIkNKK+gfOQB1phwbPob7SyG4cLnLloQ2rzlk1QajSr0pRsbMkh7t
         +0ynwdFJObqBTjUm2sCxN/UPsKlVTeu5dUE2M99cLst07n/vab3FTZjedaH25toVJggJ
         JPT6vLpns9LGejRgW12V/2m/zSBS7Q9CPeqrHOoAliZqde4kcb5xa/OFRsiNBzcwzATP
         xodHm5ubOhlQiD6T1hya8Qfdk5RwEcHDc1o+Z48OtX+Iv3YRHSKUjdgRSI4gxy6JsqDJ
         l0fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737658712; x=1738263512;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sVvT7NP9aO9EIv6Tv5VTAY7tEo9/tNIuoTqsrg0VSvk=;
        b=wfrSot7qWa8foQx8lOL/W6oxnS+Rv5LawcNZRhW1Dc95D2aoNesQs98u0OAmyMj9kS
         O+NFZgRa22Jnj/POyL2rZ/4beWHObL+I9qfRofGeJpxudgp24GJtnG5Aq5s+Sw4eSGID
         eDHM6Knm0gr5OWRGqLRyB2+EV2zloFsPhUUIikXVH6ub1upw9wRXnMUOW8szBFVdNK4h
         2r23ek5e0WCncyGwbCsR9LLfaJ+Yeggrfz/1XKAwchgpapQYzvHbzKMqOFCvkbQjZ39k
         3CYoVdCWzInYjLsozkmSiPi9cvFwA0RtEVVqoBDUlgZfvceURNpdWnqsk1oZGYchW3nt
         R9Cw==
X-Forwarded-Encrypted: i=1; AJvYcCXbyFSbFu+XaUZ03Erw6zwYJBVIyEye30tB+IXa3C/yiBL+0EnQMazDJcYgyeFQUPibdEOmS/kYBdvjrsk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVihSpZWsioeCOXHGjTW6EvqUsvimWRQa4NeNNod89nRjHPebc
	GSmRGbTa27Xm0NNb2ybWlq+j4sifr8lMuSy1aivEAsBnLnII7o3UskY1Gw==
X-Gm-Gg: ASbGncuMY2h3w2KsfpBXXH7JQ+zYKQfPzB5vYu9xUS7kclEoyLmm2MMbO1shRHcubbW
	GYI7AKvwqZXv1FITc1FPN/Ms7+25Z2dVFiFVjXUdoSF6PKFLglmFuVgLP4N9wXFeHAwdDDxInmL
	bIQ1oIBCqAUxDvgZCSY6tiR4NAGj51oGR9LBv2xn+oqmlUSigYQKI7LIIZiwhx4LHlzNfcL6wd0
	XmLIYKt+NxZZRdH2TuoVP7ajIzoJf/0BQLObmjnQeaO4Ne2odgH/mCCxiz0Diii8Hsf60htZGsb
X-Google-Smtp-Source: AGHT+IGx/gyP6KI6eRMVx44Gk3ldDLPOP4RK1jdSV2B9MGmB0gTv/bbqBcGmx/zbccrw+Kcozo/u4A==
X-Received: by 2002:ac2:41d1:0:b0:540:2ff1:3c7c with SMTP id 2adb3069b0e04-5439c22a843mr7377804e87.7.1737658711804;
        Thu, 23 Jan 2025 10:58:31 -0800 (PST)
Received: from pc638.lan ([2001:9b1:d5a0:a500:2d8:61ff:fec9:d743])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-543c8368497sm9644e87.151.2025.01.23.10.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 10:58:31 -0800 (PST)
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
Subject: [PATCH 2/4] torture: Remove CONFIG_NR_CPUS configuration
Date: Thu, 23 Jan 2025 19:58:26 +0100
Message-Id: <20250123185828.460836-2-urezki@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250123185828.460836-1-urezki@gmail.com>
References: <20250123185828.460836-1-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This configuration specifies the maximum number of CPUs which
is set to 8. The problem is that it can not be overwritten for
something higher.

Remove that configuration for TREE05, so it is possible to run
the torture test on as many CPUs as many system has.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 tools/testing/selftests/rcutorture/configs/rcu/TREE05 | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREE05 b/tools/testing/selftests/rcutorture/configs/rcu/TREE05
index 9f48c73709ec..d6fbb82e3e6d 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TREE05
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TREE05
@@ -1,5 +1,4 @@
 CONFIG_SMP=y
-CONFIG_NR_CPUS=8
 CONFIG_PREEMPT_NONE=y
 CONFIG_PREEMPT_VOLUNTARY=n
 CONFIG_PREEMPT=n
-- 
2.39.5

