Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7FF9283FE1
	for <rcu@vger.kernel.org>; Fri,  5 Sep 2025 09:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757063285; cv=none; b=HJhq6NZJgy6HQ+JCo6cz9+F0CEGe+041WL1gy1x/8OvNqov3buLEUd4S9ETtDvinfUOSpKWsd79Guxj5z6Y8RWBHVeuuNTsLEdu1xGQ1vQUsoE1xGxtsyVrsJS1dol13FIALPY+Jz10VBN3Bp53CHsj4uL6Iddulpxe4JeAXd3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757063285; c=relaxed/simple;
	bh=1zF4ped0JCfrpWQyfByH3Csxtam+ue4QKqQ7xKEVUIo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HkmHfk7jRe/Z5wo/F3e/1CBusIV4NSqTp61QpPIL1GDg8fyLGJuk+D8rEuwv8VUbekIgDMyqXwzkZVQZLVjFeSBdNy6r8neWxiutZsEarLAo+8xtHnNH7e6gXV1tP9eytDnwbk+ZMEsVP2iuoOu4J11GZeDK1Xy5sV4JNkZ3ZXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PrJjvlkG; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PrJjvlkG"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3d1bf79d7acso1101116f8f.0
        for <rcu@vger.kernel.org>; Fri, 05 Sep 2025 02:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757063282; x=1757668082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xBJDT20pfEXOkjhhpY/VXucFpS1NHhYqFSc/i9LvNFY=;
        b=PrJjvlkGz/Ne4nIpJQbWN5BIO8AZTFUb7QWPeCeYcVn4cUd/kxf0UEjJFMDJSjQvsn
         t5Vpj6MwY4vDoxXp3hPpMbHhDxdyPlH9j+ZEzhMwkSwHnLyHsj3k2NdIMsKl9IBNBWfn
         /KUdsTmWFX+B/vqA6XjsAekaWkWjUegl8w9UotKCF0e0Z46sXsIxTgs3vOEYv9gbeCJa
         xC7Ja7G8A95Dhe/2lHTiqdx6Or0JaVrHvP9dMVh4PySmnHGIJjMXbrT4UuyJv7jPeFVM
         Fwngjudc5wKdXF/6RLu0j0VhdVNR9De6AuyyuoMAFJiiLMOpn2Wdw6mmY9yuJWriBHSh
         JtKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757063282; x=1757668082;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xBJDT20pfEXOkjhhpY/VXucFpS1NHhYqFSc/i9LvNFY=;
        b=dJlylS5tqf2Le5CreEKMC3J1ZD4gDuaCxoWR+IRI1TReRGq9ABsflVFrBW8+fY54UP
         lKBt0cgES7W7ehS8VcuPQeQe2+Pyp9qY1jEJlvhbaIpfEEd3LAclQde5b8SBKX97oxbk
         Vc9G/Qc6gw2kQCr8EKb7TiwsCo9Qe7kooKnVArUJzuzCDk9Brt4jf2/GACtzdGMfDDO9
         EpjqvUfJViORieTIPKRyeTX83M4Z41OJ/Bu/2mmv4+rm+AGjS6QOJj6stsZ3tX8DdDMh
         Y8MqYob8s/N5DT73g/e2Na3H9uPeXyUpRMaEK54lGdLKV+515Gr53/t3NGNcG6LC6aE5
         9DwQ==
X-Forwarded-Encrypted: i=1; AJvYcCXPaONrAGr/Pku28KEqoCiJXEKekKzmeMCi7+y8Usk0qNd3OFFgKd86z5D9eiwLuZIyea0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSYIZTa7e9d2FWH+gab+Yo9/bxIRraLetvmg7CbOUWcytPgUgc
	/cuR3GxHjXzIPZYhwUWl2QezsdBVkNB/RhwpkBL3kgOrj581uwmBXEMPiLfbXcv6lys=
X-Gm-Gg: ASbGnctQYSmscAzNOIkFJs0brP+R1UlNeNMaiv5q9OD+Cs26QRCqvTQgfSrkDtGLOqD
	BKyh4KdEp8mJYkQ5Zx7xP1ag+vZgmNJNaNTCmTarb7EJc1e7i7adoEj1F0EsjAJv+blC9a9j8l3
	zE6d6D5xJ//+PLYV7i8OU30G5cZLjbmru1xSr5olNf7aGaiWLD/YRQnDOj40hYNC9brrhqkRofj
	IAHkGnics2x/UVpi+KTbWs13C6Nz7BS6bdNYUbo4f6cnjnNDWT1RQNW7HK03gctUBGLJvI7jxgw
	qWLAPqli1Yb/4MrhfsWnZ2BPwKOMGHuTVU6H/UbVnll77Uct51ykVQ/huu+oEFkenBciCYmmJuF
	8vYGqbGBHFSuBF1If+MQfN6wzGLY9Ixcz7JLN1hCJLpQpKXk=
X-Google-Smtp-Source: AGHT+IF70anKgRw6wAGn1dfUgMIB1wbFZ76sqlJNdsBKrD65DfS49bp2Si8SqcEceEqcUooqlqTOMg==
X-Received: by 2002:a05:6000:2283:b0:3d0:e221:8922 with SMTP id ffacd0b85a97d-3d1e04bddc0mr18173649f8f.46.1757063282299;
        Fri, 05 Sep 2025 02:08:02 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7e7fec07sm311505335e9.10.2025.09.05.02.08.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 02:08:02 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Jens Axboe <axboe@kernel.dk>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>
Subject: [PATCH 2/2] rcu: WQ_PERCPU added to alloc_workqueue users
Date: Fri,  5 Sep 2025 11:07:47 +0200
Message-ID: <20250905090747.107232-3-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250905090747.107232-1-marco.crivellari@suse.com>
References: <20250905090747.107232-1-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Currently if a user enqueue a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.
This lack of consistentcy cannot be addressed without refactoring the API.

alloc_workqueue() treats all queues as per-CPU by default, while unbound
workqueues must opt-in via WQ_UNBOUND.

This default is suboptimal: most workloads benefit from unbound queues,
allowing the scheduler to place worker threads where they’re needed and
reducing noise when CPUs are isolated.

This default is suboptimal: most workloads benefit from unbound queues,
allowing the scheduler to place worker threads where they’re needed and
reducing noise when CPUs are isolated.

This patch adds a new WQ_PERCPU flag to explicitly request the use of
the per-CPU behavior. Both flags coexist for one release cycle to allow
callers to transition their calls.

Once migration is complete, WQ_UNBOUND can be removed and unbound will
become the implicit default.

With the introduction of the WQ_PERCPU flag (equivalent to !WQ_UNBOUND),
any alloc_workqueue() caller that doesn’t explicitly specify WQ_UNBOUND
must now use WQ_PERCPU.

All existing users have been updated accordingly.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 kernel/rcu/tree.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 659f83e71048..e763c3d1e851 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -4829,10 +4829,10 @@ void __init rcu_init(void)
 	rcutree_online_cpu(cpu);
 
 	/* Create workqueue for Tree SRCU and for expedited GPs. */
-	rcu_gp_wq = alloc_workqueue("rcu_gp", WQ_MEM_RECLAIM, 0);
+	rcu_gp_wq = alloc_workqueue("rcu_gp", WQ_MEM_RECLAIM | WQ_PERCPU, 0);
 	WARN_ON(!rcu_gp_wq);
 
-	sync_wq = alloc_workqueue("sync_wq", WQ_MEM_RECLAIM, 0);
+	sync_wq = alloc_workqueue("sync_wq", WQ_MEM_RECLAIM | WQ_PERCPU, 0);
 	WARN_ON(!sync_wq);
 
 	/* Fill in default value for rcutree.qovld boot parameter. */
-- 
2.51.0

