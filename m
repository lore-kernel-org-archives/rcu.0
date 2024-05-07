Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B42E1607AD;
	Tue,  7 May 2024 09:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715074576; cv=none; b=HQyr6P75Oh/Bii6zt6nS+1J29hEPRVpWvOZ/xG8sW+9CZ+YJ6h9nB/MNH16ghIckVlDcGpc0OI7Uh2vL018m3WlFNfe59dNhlIxQGPMrH9yFOgknle78ibNQpJexDwPQwrCBk2CCEYxVla7WK/Wctj6/X+/UUyZGgYpzMSy381E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715074576; c=relaxed/simple;
	bh=xpb7OlvSSo1eFdDyHPiIjhWcGu0wWewuK+3bzuPFsbU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oDx7E6bIIuJZAPkkG3+qL1D4xxwT8nI3YZ6tLTT8tp37DLR/T/O+wUnBQ+Jexg7Cc1cseGzrMIFcjk4tcZZHsz4kTNwaj36yk+5/5trXXJgtMZVn/vSepL9PNW9Lrh23TWuAwdr3iGjcnDO5EPIe4uhKxJ8rLrtCan6HpKWFFEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KzKq8LMB; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KzKq8LMB"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2db17e8767cso36158051fa.3;
        Tue, 07 May 2024 02:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715074571; x=1715679371; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CKbmQWc+9T9jJILreLJTePG04vL0LrIDb9GwepNxo3I=;
        b=KzKq8LMBOt+2tgNLhCa41kfA9tIxfLFoR2sL0JVEa6uN6iTYBMsCK6FweM2rBql4+B
         5UiZKHKfjBRH2yslcqM/RgqrfLiL3ZIuWh+8VnH0RuVLrCZGPT0eDFqRX4+uz3groWgb
         rfW5EeBVHFDYHrJE7U0+vYvl5giAzeCgM0fZT45pQhEfY9N4T+5+XxiPFyAbcsVtMlDy
         gaD4ZjEGWGkFQKY9FOxf5u1wT5EAT/JtmWKFbFZVJHrzwV7dPRPutvfoQVyHEBYV3B8s
         jyI/hPUAL8N1edfBSf4wygl9iyClVkDc0Is2CdkrMWJcANQQOPr8cRIkcekcxloIyaHM
         ZDNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715074571; x=1715679371;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CKbmQWc+9T9jJILreLJTePG04vL0LrIDb9GwepNxo3I=;
        b=WZevy3W2ZuRDRev0X3ou525e5aT+jyUMZG0YxDwqzZ1ZLWxXdyo8fz8ZSxA3EXhEhZ
         l6IStfPQz08+uJJBMTRAGi0uYDgZKEVF4AHw6+Kx4lclntt8MSOmQr22TegL7/QUr2My
         rMJWVgkBqdbgLCMbnsuNkPZbajpsw625orH1qYbaPnYpEpg9M+Hpj9Czd72fZk48F0F/
         j49jaKoZlnP7T/z/7Sms6bWZfSfclrsv/69KuQ4r8/d8bZy4UlYsapyiO4Sdi3soMArU
         aQekBuPkpKdrCybZJL04+5Cq+LC5c3hpQklF6ptzC/NTQDbuQwTLK2wlDn1+WzcIxDh9
         Wz8A==
X-Forwarded-Encrypted: i=1; AJvYcCVeYJz7bnynwWwl1mK662tU4C35a3al1+yODJCkP2ic8mhUAuCzIL8tXjtmhG2UCctitt78Pyel0ynY4BQwMY1eyi6i7KivEcLmNBFh
X-Gm-Message-State: AOJu0Yz79mz/KPzjKFvDd+e31kefFhVkeJZ0GILW2DKb0Kh/+cXBQGjQ
	BTjWUZzyKUpvWCVtcM6cb7ZXqj8hzV8yu28OaM6GuMAjSqcpRrPK
X-Google-Smtp-Source: AGHT+IEE9OwN9hgrxrUXXrlzUlyEFsgLBZf8UOvqt+QLmmzylv0mw7r1Pcmk4kRtcP4ng8Sd1BwtMw==
X-Received: by 2002:a05:651c:201c:b0:2dd:c9fc:c472 with SMTP id s28-20020a05651c201c00b002ddc9fcc472mr7408812ljo.26.1715074571380;
        Tue, 07 May 2024 02:36:11 -0700 (PDT)
Received: from pc638.lan (host-185-121-47-193.sydskane.nu. [185.121.47.193])
        by smtp.gmail.com with ESMTPSA id t18-20020a2e9d12000000b002e29c50c4dcsm1335473lji.27.2024.05.07.02.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 02:36:11 -0700 (PDT)
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
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 39/48] rcutorture: Remove extraneous rcu_torture_pipe_update_one() READ_ONCE()
Date: Tue,  7 May 2024 11:35:21 +0200
Message-Id: <20240507093530.3043-40-urezki@gmail.com>
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

The rcu_torture_pipe_update_one() cannot run concurrently with any updates
of ->rtort_pipe_count, so this commit removes the extraneous READ_ONCE()
from the read from this field.

Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Closes: https://lore.kernel.org/lkml/CAHk-=wiX_zF5Mpt8kUm_LFQpYY-mshrXJPOe+wKNwiVhEUcU9g@mail.gmail.com/
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/rcu/rcutorture.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index d8c12eba35b7..6b821a7037b0 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -461,7 +461,7 @@ rcu_torture_pipe_update_one(struct rcu_torture *rp)
 		WRITE_ONCE(rp->rtort_chkp, NULL);
 		smp_store_release(&rtrcp->rtc_ready, 1); // Pair with smp_load_acquire().
 	}
-	i = READ_ONCE(rp->rtort_pipe_count);
+	i = rp->rtort_pipe_count;
 	if (i > RCU_TORTURE_PIPE_LEN)
 		i = RCU_TORTURE_PIPE_LEN;
 	atomic_inc(&rcu_torture_wcount[i]);
-- 
2.39.2

