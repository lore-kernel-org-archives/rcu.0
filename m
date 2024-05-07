Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492EE16132A;
	Tue,  7 May 2024 09:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715074576; cv=none; b=eLScoywT3IiCVcGdudtka9etOgJMH1S5JzXyOAEodHFJuVJSXfstqF2JNQML0iGRJwZueItSym5tdLRxEhBtTyEWuUOmxw3QYfOLd3SjnHXejOM6ceROulHcFTO8eMl49dgbe9v1Nb+eYRWBQkx8NONzZ+8a9WgliO8RBFrf8TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715074576; c=relaxed/simple;
	bh=zwo8GaVLL+3hw0Cv/JQfcpn/MdzBC8bJdprk9Rpnixk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WTKRa95nPxIXeZdFoyY0zq+kjGIoJvDiykWIH1ZnXeWcInKESF9OXjhvhCI2zK6u9gRIYvidpm6G8kum3ajcb2FpSCP6luljIb9zy1HDyAYu0VtX10GCk59vMnAHbKuHQPtf6eoV6tTlWaNY1t6wPzRhGngjXUEo9GpTERJ0v+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OmlFqxHR; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OmlFqxHR"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2e1fa1f1d9bso55712111fa.0;
        Tue, 07 May 2024 02:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715074572; x=1715679372; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ALGD50dfBLDLVyD3Lt2LManagWExKBPG3j+4x0bgOm4=;
        b=OmlFqxHRQB7f/Q5CnuQ5h25j29eEJY70I8EwbfW9QC4ZMqIfW0n97Q2GyH6yhLBiIJ
         btyWzjsgbe325QjS+d8Mj4NITSmANzukzRjHBsVCHShzOXHp+aeIRb9dLmDtA+DKTYjL
         ObEzVh0denAbbR87P9xpT9flHWUHfsQjlyfmZoyAh/pEo7+HlboMUQ2ixTsKt0OMQZld
         7++H0WLtFDZF+QBNbq7fhlxF9eduP3eYQDn/hgcxzaAlC4vIAYZ2CxRUgraMCdidmoac
         vmlFvh1wkHcp/fhNFWPY58uad89emWN7BlsRStn6TDSsGL5PV0wQjlTN3xop1G/t8CbM
         +BCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715074572; x=1715679372;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ALGD50dfBLDLVyD3Lt2LManagWExKBPG3j+4x0bgOm4=;
        b=vyM6BJ9KdmLo+dl3iUt4x55bQ51N1H4SKG17I+Dx/FSofBj3GN5rlf23YWLlGp8JrN
         3LNuODvb5Hc6tEEp0rk1sXS3u0gdPj799+Yb5VSs8k9FWb3SmbOylUC71AhIMBOLAuAB
         FrjsvVQBIOJM/NaPRS0fli78pn8RgYuPuHyvll1FzIkyhUNqDdkRdR0pjuDLQGLrMlLS
         sQ/W3EPfvI0EyRsKJot0o0jwiDSe7tqokEgZIEouC278aOvcXyc3OxP69A9zBw/Md1BW
         7TKu3VmBtL0KTpsotSKN1wqslKtahzifZMa7H1qNzOekrHG/NU9nnMLL6rFGHNAdaa7f
         5W4g==
X-Forwarded-Encrypted: i=1; AJvYcCXFY64HWFHn3N9goTtcBfF5fci3NXvDPUjALwpoXytY02zSotEpIndJpRmPhkUJmTgRSFgxRsjueZS5ZTDmuHVJ+CzZ0kdV78QVxQLx
X-Gm-Message-State: AOJu0YxhRd0cKzDjE5qLQvz7F8uZeRqrjoZsAPA+C0By1UXX5SaGx+cS
	5C8XJnOnxVoWgolTHWC62v9flp15ypa4130Hf7mCgfuhokDs2nzl
X-Google-Smtp-Source: AGHT+IE1aRpC7BZU7Jhkp5OgFGXus4CGvWnQDyQ6L4ZqGSCbouY1bqByQmp89pOOsJCJ2NM9xABHcw==
X-Received: by 2002:a2e:984c:0:b0:2e1:d94a:771d with SMTP id e12-20020a2e984c000000b002e1d94a771dmr11437082ljj.4.1715074572233;
        Tue, 07 May 2024 02:36:12 -0700 (PDT)
Received: from pc638.lan (host-185-121-47-193.sydskane.nu. [185.121.47.193])
        by smtp.gmail.com with ESMTPSA id t18-20020a2e9d12000000b002e29c50c4dcsm1335473lji.27.2024.05.07.02.36.11
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
Subject: [PATCH 40/48] rcutorture: Fix rcu_torture_one_read() pipe_count overflow comment
Date: Tue,  7 May 2024 11:35:22 +0200
Message-Id: <20240507093530.3043-41-urezki@gmail.com>
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

The "pipe_count > RCU_TORTURE_PIPE_LEN" check has a comment saying "Should
not happen, but...".  This is only true when testing an RCU whose grace
periods are always long enough.  This commit therefore fixes this comment.

Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Closes: https://lore.kernel.org/lkml/CAHk-=wi7rJ-eGq+xaxVfzFEgbL9tdf6Kc8Z89rCpfcQOKm74Tw@mail.gmail.com/
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/rcu/rcutorture.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 6b821a7037b0..0cb5452ecd94 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -2000,7 +2000,8 @@ static bool rcu_torture_one_read(struct torture_random_state *trsp, long myid)
 	preempt_disable();
 	pipe_count = READ_ONCE(p->rtort_pipe_count);
 	if (pipe_count > RCU_TORTURE_PIPE_LEN) {
-		/* Should not happen, but... */
+		// Should not happen in a correct RCU implementation,
+		// happens quite often for torture_type=busted.
 		pipe_count = RCU_TORTURE_PIPE_LEN;
 	}
 	completed = cur_ops->get_gp_seq();
-- 
2.39.2

