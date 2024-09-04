Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9EC21DA2F1;
	Wed,  4 Sep 2024 14:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725460785; cv=none; b=JVNuCAcJ340KPeILDDh/Z7vWhSC3qQrE2diNxv1pUi1iJEHmMUtWwujU6WrfLF9xUtpFy9JdeMmMT6Muf8H61llWiebkXAzRmG3XCnTj0uqx/Jhf8AL8qCWmITedHL35FkMMt8f/SvQQaPX2T4qB9DMPzBaNW2whFdPBhcJ7bzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725460785; c=relaxed/simple;
	bh=RsdcS3XLO/rjqlscQZAtyR2R7r2lA3TDT35ny7Vsi2w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g7hqW/LwR8T/DNt5nb1+MpWmrnrHrZol4pHf4ZFIGvJCgxcSUZXnQPx94ll5E9patezoTBiVYbKgXusph3Yrr63Vgz76WXkrHiWDxCRLBqUHVouaPfXtxWJEifjnU9APEfq8QMVH9J9LMrUXXVVc4+tg7Hyj6AvdEAEXe4NF8k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gfgh4y+v; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gfgh4y+v"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2f4f8742138so75429791fa.0;
        Wed, 04 Sep 2024 07:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725460782; x=1726065582; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y7IYDmb2i6sr/ZP2ugB5d7CINftSIiZO76zk/t7J0bY=;
        b=Gfgh4y+v9JxiB4hQ5TQHtHWOze3xXHLk9GY6TIHJ558vJqB9bHzjOSKDQVFfvFFciU
         YeGZvuYBFNxvObqs/JPAe0AYQX2mnQ1zof7R8zW6ceX7oH0oRKZfU+Of1J/3JQouvXg1
         Sg80HO7yCKxh5DnKb8WLBZyuMAP9q0ejws+JB5ONbWil3sm7zqEKCr7DgWkv/0vZviqd
         UMvY9AwctWV5PTE+Gva4bS0SvjpOZ8wr4oL236b0XwBb8cn0T3kDF5nyS7mBbO4+/RPm
         jeSSSHyWUeprXuES5LmkFLX5EbcTUQCf1CtFJRsJCpkMhOzRLJv7hDbG+es2MZa7kysR
         xiYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725460782; x=1726065582;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y7IYDmb2i6sr/ZP2ugB5d7CINftSIiZO76zk/t7J0bY=;
        b=WLjCUZYPe2yOk/KNKfqIw3dcy+k0CA+lsyecrQoSyoLVXtRwtORYAJi2iW8uzXHz27
         NbRU6gnvjnm87Y/r6Eg3nu31sPcL4jtW9FyqYF4KJdnJuYxY2oq1mflyNTon7d2I2YD0
         y5+WkNES7TzcQ+iXLhDgyZpdaqtmW3GREKOyLPK9A/gFZpYx0LWezuiqlSPPU7LQzTEP
         3DQgUpm1LLN1svGaxT0fue2gxo/u3yIV8oqoER19VqtyHXjFzbA0kGR3ohdOGardXPLK
         hklbkMxyqLIFlElyqwmG7QPI+/e3HDfD8GmKAQnWzCStLQdnY4jZMXk11YkpHHBCCwwr
         jVzw==
X-Forwarded-Encrypted: i=1; AJvYcCXdjVLziK2LAhkT7vJKYVxRmtS2zUepW+DxjIyCCdAAMAZfjbethT+P4xtuDAtunyZAGjkpFeJscGEKvfo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBtKD/FB7hmZxggwSS8o8UohgjimfI3z4LOcQUjfb3m1SV3v7Y
	hQCPRu19fW35QUBtXkIe2eseJOa5XxhZRbt25qvL9f9mtS4BZS17
X-Google-Smtp-Source: AGHT+IG8sQ4jrin9viZNyNXjo37NpRtiJHVmHlPTQfJqK6+Hge92ANHIN2Pds7XN6x1VJyj0ylSP5g==
X-Received: by 2002:a2e:f09:0:b0:2f6:593d:36f with SMTP id 38308e7fff4ca-2f6593d03a6mr13297821fa.28.1725460781541;
        Wed, 04 Sep 2024 07:39:41 -0700 (PDT)
Received: from pc638.lan ([2001:9b1:d5a0:a500:2d8:61ff:fec9:d743])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f65eb480absm1375591fa.51.2024.09.04.07.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 07:39:41 -0700 (PDT)
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
Subject: [PATCH v2 1/2] rcu/kvfree: Use polled API in a slow path
Date: Wed,  4 Sep 2024 16:39:37 +0200
Message-Id: <20240904143938.119964-2-urezki@gmail.com>
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

For a single argument use a polled API to see if a GP is
already passed. This allows to bypass an extra GP request
in a slow path.

Allocating a page or dynamic rcu_head might take some and
still fail, in that scenario a GP which is requested on entry
of kvfree_call_rcu() can be elapsed. Benefit from this.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/rcu/tree.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index e641cc681901..182772494cb0 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3789,6 +3789,7 @@ add_ptr_to_bulk_krc_lock(struct kfree_rcu_cpu **krcp,
 void kvfree_call_rcu(struct rcu_head *head, void *ptr)
 {
 	unsigned long flags;
+	struct rcu_gp_oldstate old_snap;
 	struct kfree_rcu_cpu *krcp;
 	bool success;
 
@@ -3799,8 +3800,10 @@ void kvfree_call_rcu(struct rcu_head *head, void *ptr)
 	 * only. For other places please embed an rcu_head to
 	 * your data.
 	 */
-	if (!head)
+	if (!head) {
 		might_sleep();
+		start_poll_synchronize_rcu_full(&old_snap);
+	}
 
 	// Queue the object but don't yet schedule the batch.
 	if (debug_rcu_head_queue(ptr)) {
@@ -3853,7 +3856,7 @@ void kvfree_call_rcu(struct rcu_head *head, void *ptr)
 	 */
 	if (!success) {
 		debug_rcu_head_unqueue((struct rcu_head *) ptr);
-		synchronize_rcu();
+		cond_synchronize_rcu_full(&old_snap);
 		kvfree(ptr);
 	}
 }
-- 
2.39.2

