Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6563D17CA17;
	Mon, 30 Sep 2024 11:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727696237; cv=none; b=BhkdvhqP0FavvsiYkZ3iqsN2r/ELQevtwIXiKHsBS1OGZSXoWd4/WeqO+WFLTq6UvHG7K8+M+yD+hHuTuROap+dRldhspJqWZvFth+XKlhlL3TMkpZTiv2hiI1hq5azubmrAu1Vvw9iqk0DeUB3nCKz9N6ozdfTXeJqkaRekiR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727696237; c=relaxed/simple;
	bh=FyvIzX2J4QCmwHO7Zih4e/9cezEiSl2n09knZnq5RwQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Y1Rrsd/7ou5pPwuyYZHNGvrm/PVWiM/UbCk2vZfoe/95buPxTbtcxr4UayoaSJPoIxU0mVTx9ftJ0tRydJ+bu8oXhr3Qmo1azIW8/4MkoOR8dehK38S0TucEaWktT+snHWNpI+TbcpqTaCmyd5uAQnR7uZC71jFkVyKNVJ4IPws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vfmtx40T; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vfmtx40T"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5398cc2fcb7so1789678e87.1;
        Mon, 30 Sep 2024 04:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727696233; x=1728301033; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tyZcUMUAegpNAvD640Pc8Za3YSgkV9krfroLC5X2l+A=;
        b=Vfmtx40TcJ0laGFr6ArDjrGbFnXK/KOzugExOY8/Shv69FaTVuM4rN7FlCpZeTirav
         po0k6kv+GvSeUBNuODO73kcdt3ltQvteqeYq7h/n/U7/3BEk98j2eY66L2a7XixXXRdL
         ktZqRk4iuGgbz0NKQs6e9OAUP+lcZdlZv6nMMjK4Nzy7CMe8EUdS3ehKlE1iwggklG3f
         ACrXI4YmtXaJeN9zLDBs329KIf7ystF6xMPUdeJJi6eJgLjJz/Yin/Sknlteawi6SGeP
         f5te8s68Ufhij87nZMJ1VJNus1Jw2k+KBnqgCVWvaaAA03NtQn43Y0niC4iT6+gibWH2
         4yBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727696233; x=1728301033;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tyZcUMUAegpNAvD640Pc8Za3YSgkV9krfroLC5X2l+A=;
        b=xUO+0tQee4J595nP4LSGokfsWyhGTlRwHcJAsLdLa8DhTCUH3kO2m/67+8NQly3XJv
         AELHoMXtCZyKuXauc8LXbu626cTky1JDRYmoheJVr1q8otkGhQis648+AGQo9j+2Gh/q
         XACWwztWmY2sZROc1zciuX3xujG3toJQdCcbQ3zpHy88Gyiqenwj9NPZGkfkKGNhQwiy
         xS4K8MVF8J5E60BmcNHjeo2v6FUJOFyLz7+ZVJ2buGYkwYm4QCkgZ1cJ6c2hLsA21T97
         9nhbzxTF6I1qRRJ4eumxHxj/aD8V6oBkR/7El+qejNFmdxdvAVSQMXG21KQ4LgQ1BP5h
         MAlg==
X-Forwarded-Encrypted: i=1; AJvYcCW0A/hVC3u0w+xM9drspX4eiOsdKEfio1lnn5FS0LBNeqwszJW7pMbUVGvQy/NYRTMtCZq2I+9b7HZ4DFU=@vger.kernel.org, AJvYcCXGDCx08FXVyuzZ3KLvoLkfhZE7aMJRvrPibgaeTb8mhu4GKdv+EHA7rqbPVI+SJI+Lr95E@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0alqnG5JF8JmPPqZ3nyzZ8smxITwJeXcgN9AyZNeRx82RkhiJ
	zoTqE1CDgnxF4rRqbuoyRMfcl7QaHgqt/Fpm5SC/7qleZSl/C7EC
X-Google-Smtp-Source: AGHT+IHUaAhg9KQgh8A1ZU9wg+SL/2DNNV/9m+UwXwbZE9MiidjUVI6cMxKxlQe6d/jTrzmr1O5nQQ==
X-Received: by 2002:a05:6512:158d:b0:536:548a:ff89 with SMTP id 2adb3069b0e04-5389fc6fc0amr5914529e87.39.1727696233087;
        Mon, 30 Sep 2024 04:37:13 -0700 (PDT)
Received: from pc638.lan ([2001:9b1:d5a0:a500:2d8:61ff:fec9:d743])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-538a043992fsm1219820e87.210.2024.09.30.04.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 04:37:12 -0700 (PDT)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: "Paul E . McKenney" <paulmck@kernel.org>,
	RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH] rcu/kvfree: Refactor kvfree_rcu_queue_batch()
Date: Mon, 30 Sep 2024 13:37:10 +0200
Message-Id: <20240930113710.637833-1-urezki@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Improve readability of kvfree_rcu_queue_batch() function
in away that, after a first batch queuing, the loop is break
and success value is returned to a caller.

There is no reason to loop and check batches further as all
outstanding objects have already been picked and attached to
a certain batch to complete an offloading.

Link: https://lore.kernel.org/lkml/ZvWUt2oyXRsvJRNc@pc636/T/
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/rcu/tree.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index a60616e69b66..b1f883fcd918 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3607,11 +3607,12 @@ kvfree_rcu_queue_batch(struct kfree_rcu_cpu *krcp)
 			}
 
 			// One work is per one batch, so there are three
-			// "free channels", the batch can handle. It can
-			// be that the work is in the pending state when
-			// channels have been detached following by each
-			// other.
+			// "free channels", the batch can handle. Break
+			// the loop since it is done with this CPU thus
+			// queuing an RCU work is _always_ success here.
 			queued = queue_rcu_work(system_unbound_wq, &krwp->rcu_work);
+			WARN_ON_ONCE(!queued);
+			break;
 		}
 	}
 
-- 
2.39.5

