Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D801D88D8;
	Wed,  4 Sep 2024 14:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725460786; cv=none; b=Eud6CcDo15qvLaCZ/VTk+h6uzDMbPFy4XlXStnJkgl+Twdv0T5trDhfPndSXVhGeBGwLBoKjIiR+/vpVEvwg6Qnj/FSUx4TF2sOTXTNC7QpZf4tRgqa+3uktnAGnoVwcvhWsZFLbAxvsn7/EN34UYAXit5Hnbiiec3BsyA+7wAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725460786; c=relaxed/simple;
	bh=CBcEZmdHobsvIOFA2N1uEHl30j3tCoArg6oCafX8kTQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sL8nvxD5VEg8sxqZgdpP82hT+FAVnaFWJR/aFwUUxruLlDpWaokhlMMO27oMtYcoWlbx5rNhoIawiJIyW79zZ9Cr7cPbosLYizzbMKGxJluTKSB9IaOHlB06DHJmQEwY6qUVrEk2uPz4DHHi1nRAru5jVtcrbufTO4RarYK9Om4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ebrt/+xT; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ebrt/+xT"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2f50966c469so76303511fa.3;
        Wed, 04 Sep 2024 07:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725460783; x=1726065583; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G1t2IMMdcOOGIGKMQPUq9EL3DGfWZ0NZj9kyQG6uBN4=;
        b=Ebrt/+xTe7YbPWzgau6ClgD12oHvwbUOiGbggqDfYYmvyrYVa1/OKp2upNYyEasuXf
         Rh8VlvTMqCzOP/Un4rrXrQaaY99Vd5vRkupUS9zimVOYHthTzHavrQE53mYxbKBxpET0
         wvjJxjMh/4LtXfJJecA5w2Fe8g8/66jg33kk6jw/5mha7ezFPF+hLG+urjTMBs76rp5I
         GbaSU+w9kafZBSklgTTu9l6ZIPlN9pQQE3gYdApOmGUtQzwJ7eFZdAEqRXrUuhk1cJfS
         eEHhDpOYXGVCx7LFxp/jjJt+rkCiBiXAeSmYsS1mGRRuefpxo4rBe71clxT/5KJsdASS
         0V1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725460783; x=1726065583;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G1t2IMMdcOOGIGKMQPUq9EL3DGfWZ0NZj9kyQG6uBN4=;
        b=B6L7w15zsOhIlTUquUHUdzzQoNrz/z/YW7+7fhkX7ujOqS0tcleMpV9lN3PEBMZW5G
         5NfwVCfE6e19pPgJVCRyxcO/NGBTjAT6/xhCviydfZRQHCLn4XjL8mrh9ab0HF3zqgqB
         nbYIp0u6pMsKnLqZAkrp2t7GunaK18BP8rrhruo0kRtgaWIJ7BXugQ8/Gp2ZmZRkO2kR
         IVuX4FvK07h33FPnvS/r8X/+4N2MftE/wZyktQgl3aTSpIPjYnGLOh5Vo25BPHk5WQK2
         mD5BTFpTDddvmFfrRfIqifv/jFhSikmEAEagW9Wyzb+YyortLFL/JVD7WhJ0+rag70k4
         T9+w==
X-Forwarded-Encrypted: i=1; AJvYcCVK3rHeD1pIVI2AVdvcuP8AsT8P+BrJu6+wx9VArAbwjtEqdw8R1svveUA09aR0lojlgZZ2Z737jpojDt0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrZqbDldJIX1uxlAv3of62X5e+RCIelWJ7CC7p39951xiUIWr/
	uM8MGJIXcXz9OhJH1aN9lNy/VnsbfPLGaPSa8/s/mYf+S8k1DDHK
X-Google-Smtp-Source: AGHT+IH0O29+qz7GY07ruJee+XpqNAYTXOHfuN3834r5Eky87Axzph3QB/aTv59igeeyZvHdrCljhQ==
X-Received: by 2002:a05:651c:b0c:b0:2f3:cabc:6158 with SMTP id 38308e7fff4ca-2f62903f7efmr106481481fa.11.1725460782353;
        Wed, 04 Sep 2024 07:39:42 -0700 (PDT)
Received: from pc638.lan ([2001:9b1:d5a0:a500:2d8:61ff:fec9:d743])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f65eb480absm1375591fa.51.2024.09.04.07.39.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 07:39:42 -0700 (PDT)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: "Paul E . McKenney" <paulmck@kernel.org>
Cc: RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Uladzislau Rezki <urezki@gmail.com>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: [PATCH v2 2/2] rcu/kvfree: Switch to expedited version in slow path
Date: Wed,  4 Sep 2024 16:39:38 +0200
Message-Id: <20240904143938.119964-3-urezki@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240904143938.119964-1-urezki@gmail.com>
References: <20240904143938.119964-1-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For a single argument and its slow path, switch to expedited
version of synchronize_rcu(). This version is considered to
be more faster, thus under a high memory pressure a slow path
becoms more efficient.

Note, latency-sensitive workloads should use rcutree.gp_normal=1,
which will make that synchronize_rcu_expedited() act like a regular
synchronize_rcu(), so no harm done to them.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/rcu/tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 182772494cb0..87a64fcffa7f 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3856,7 +3856,7 @@ void kvfree_call_rcu(struct rcu_head *head, void *ptr)
 	 */
 	if (!success) {
 		debug_rcu_head_unqueue((struct rcu_head *) ptr);
-		cond_synchronize_rcu_full(&old_snap);
+		cond_synchronize_rcu_expedited_full(&old_snap);
 		kvfree(ptr);
 	}
 }
-- 
2.39.2

