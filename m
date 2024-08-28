Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD3216BE29;
	Wed, 28 Aug 2024 11:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724843377; cv=none; b=jNsmjRDojNBcQ8G0WevVQc/+amHvdoOewAVowRmo5n4jyIWGa9QAy845kPseJjsOyoanQ55ovO9VIgvNulrehLuw9wsxky3Jb59iAevb849sctsYQ5kZEJJyUZTdV88norR2f8HiNf1FMUJq4feemHGp90/Q96pioZd7hVOsXfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724843377; c=relaxed/simple;
	bh=EmdiYAXSn1V8R1C6ti5oSjYY5AsvoVnIkFU+Gu9fYIk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Lpmc/YSnRnh/zykKtsnw+lF2T1qXl7+qd2MFNLceddOs3rJlJ+GzhPrQdhGCj4sfXr+71iAzB+z3MgmEXnxEckc23JnvecoHDmU2iouJfm+xXbWnxMNrdjVVYkqJLUyt9NRxiJnRp0+KXzYustBAUZnd8/vEjqJ66tkXASCLCcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j6Gq91Op; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j6Gq91Op"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-53346132365so7835297e87.1;
        Wed, 28 Aug 2024 04:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724843373; x=1725448173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YlJBDzK3at9FJcjkZqyeV25YIGe2MN+NY6zLQit72Rk=;
        b=j6Gq91Op8RosC3igO1qNYCRY6HbAvEA0VmUG68YVppZhzQT80qYstLsbjhq6uJ9fTv
         cuvUFhBAzeHADKLSrEkHteEznBWviwnbdalmhNPiYRlNEDbqmzcj6Y2QdzxbBphXDDQ3
         Jio/QrR7pGkzQFlEXrbBK4IY0oYYIwczGiOuWhKMkBMpXWBp7AxorQAV6HXBNkMcg9Wf
         3iigSeKzaiPS9FImzeuygY0T65L24g8Uev1QbV60WrkfgULj/bJdyzLSG4FpxCugcucU
         tTP4L0mi1KBJN2n+Znr7Ed5lr6eFnzzCNT8WNyvy7Y7Q8sZz9ID1PcSse7tzwYp2xrPu
         OD9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724843373; x=1725448173;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YlJBDzK3at9FJcjkZqyeV25YIGe2MN+NY6zLQit72Rk=;
        b=MEsztAJslmTdrgQ6fUBfVHk1FFWFkyYoXScjnOzrQeHMWRDQ26A+iSS/GV655PHEep
         mA4AJGaNgqNPyjsJRivTvz6aFCgaA259P3WKHQNiUePMv9jxBDPt7LNGeoJYLdozeNyK
         MGL78UEZXLReiEHk/06AO5SbDw/0mxfpuOOlpOnq4amMxK+0GFok5qgHab9EyQWcEXjh
         uzMc2HfuiOU1sqP7ES1gmjW5AU/xvjRpZvft4P9LmwcGwKGMWV+WSwvptPMNQ47fLZrn
         5ZbDKGipz/7hZjA42Rv3slK3zcjKTvEl5tzP8lm2WSD0uKPpfmNOhLCLn0tXM54KOqLP
         qQLw==
X-Forwarded-Encrypted: i=1; AJvYcCUL51Qefh3Nb+3P/ludBIGpNtl4XxC9uI4cQDLF6Qe7itD65cyOTANd+v83qykQBQAyw/82AS2Zn0CaZbs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPgtgu9H5iqUV5GrqKaYmXfPaor8762pH3Odx5iN1RblinnBK8
	fmkO46Zp5gnjZDeq3jFmFpVEw+p1w0/Yqn6drrBfGpNSGz+UwsOZ
X-Google-Smtp-Source: AGHT+IHYWAI8HIOEHtLNToHxUyhLciDmOtsfcL2sepGXMbNcMRQabBvJt7C1LjY+qf27FeRdaMi6Qw==
X-Received: by 2002:a05:6512:2346:b0:533:483f:9563 with SMTP id 2adb3069b0e04-5346c763653mr1255235e87.45.1724843372703;
        Wed, 28 Aug 2024 04:09:32 -0700 (PDT)
Received: from pc638.lan (84-217-131-213.customers.ownit.se. [84.217.131.213])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5334ea5d6bdsm2154922e87.208.2024.08.28.04.09.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 04:09:32 -0700 (PDT)
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
Subject: [PATCH 3/4] rcu/kvfree: Use polled API in a slow path
Date: Wed, 28 Aug 2024 13:09:28 +0200
Message-Id: <20240828110929.3713-3-urezki@gmail.com>
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

For a single argument use a polled API to see if a GP is
already passed. This allows to bypass an extra GP request
in a slow path.

Allocating a page or dynamic rcu_head might take some and
still fail, in that scenario a GP which is requested on entry
of kvfree_call_rcu() can be elapsed. Benefit from this.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/rcu/tree.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 893ee69d4a4b..030a453f36c6 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3845,6 +3845,7 @@ attach_rcu_head_to_object(void *obj)
 void kvfree_call_rcu(struct rcu_head *head, void *ptr)
 {
 	unsigned long flags;
+	struct rcu_gp_oldstate old_snap;
 	struct kfree_rcu_cpu *krcp;
 	bool success;
 
@@ -3855,8 +3856,10 @@ void kvfree_call_rcu(struct rcu_head *head, void *ptr)
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
@@ -3917,7 +3920,10 @@ void kvfree_call_rcu(struct rcu_head *head, void *ptr)
 	 */
 	if (!success) {
 		debug_rcu_head_unqueue((struct rcu_head *) ptr);
-		synchronize_rcu();
+
+		if (!poll_state_synchronize_rcu_full(&old_snap))
+			synchronize_rcu();
+
 		kvfree(ptr);
 	}
 }
-- 
2.39.2

