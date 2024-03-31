Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B750B6BB20
	for <rcu@vger.kernel.org>; Sun, 31 Mar 2024 09:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711876780; cv=none; b=ECFhElkrK0uHPVFyX6qWe/L1KVbE0YHkBrV770MAL+wwLo/HQraWRvcr6Tg6fz6IGsQNndm8UgbP1dj2J0MjRD6trZRtWkyDsXOEzbQc0shxAuaQHz+tR6Cm134G1x19IIg/NbEQxdG4BmHUq0p5U00TQ2mHnHFdAoyAEzjl2eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711876780; c=relaxed/simple;
	bh=w7R8tc6yZJOjHFuUD6xGsSaCcEuSwepgTaqP2wSwLPo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=F08QJfDeaeeflxeYNWNsgvLNsk8iSNSBRw9Rv58Yul4QtEXztZ8ClQqpS+I/e2cDFYQqjTRwnXCcd+80CyBCn90quOkhLgn1PZfPHksisuYttsFT6JYjeq75c6H/oz3+ZMDo8CM03pjv2K7PDoNm2hVcm+xP4BZCMir+kD21Z3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HPJv8/WR; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HPJv8/WR"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3c3d404225dso1901342b6e.3
        for <rcu@vger.kernel.org>; Sun, 31 Mar 2024 02:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711876778; x=1712481578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ls85CEe6Lz9TK63Xz/7KmliXxqUAs74ugBm3pnSkrKk=;
        b=HPJv8/WR1XNW7DI2AJp5Yq9iu48El/NDME+GkW1QogHeoAXkLFYcIdmQP9z3iIMJX+
         0aYOCtGiH3TcajqUpm96ArIG5zTtRqLRYWqxgq4QKaW6+7MSFklJytYBH+hV87iYAmSS
         E+hufoWO82avl8+LM/yJ7wveObrDNh5x7uE0v8d5xwSfFuNtvim6+vxTNHgacKa83gTF
         HrzNU4QR+j85OcZyyF99ZevXWRTtHS7xDsj0xdNqvSQEwvo4giI34pYymmv+X7Cn2Taa
         j1qbbG/2G+nf5o2tA083rFQK6ZOh9uIg6FZGFsaxdEi8dwGClr+G/RRGI8azv90Y58AE
         fvuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711876778; x=1712481578;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ls85CEe6Lz9TK63Xz/7KmliXxqUAs74ugBm3pnSkrKk=;
        b=OUY6gD82ve+o9Eo7J+0pq8mRd2S/96eYSIcIEOxYNz7gJh6Fa7SGb/eY7gfSddx0aM
         IM4rZYw4mrZAIHJPB/dO5cn4ZBF+wyjybhA/8OtO5WB5jopmYTga+p5rrbqyt5sgSOR8
         w7HtMR54iFrwYCt7QOdNEG4RgheyHV7w8sJMi0dQq0RQI5dK+DEUOyYQKZE77ouGLjCx
         tYFwz2jX1VfW/wnRw5BgOyF+gtT4Yuvcri9WXz/BarbkkdEM+XNZiDi+nWGlrWWKVln0
         QERDPf/f3BAUjV+LM0/q79G/FbvUyWEBUn9+AD2XwZsErX8SAYskHUOpB8Rpj2/05WkE
         FRVA==
X-Gm-Message-State: AOJu0YzYtK2JVG35JT4PWAeIy3n1u0q4/xzHzYmV12ZO8Vv5Ql2k1sqj
	NzPko5itxo18FB+Rx0EKNc7XwYEZCMoPtLBuvsq0FIqBj5R3pN4qRCS+YvMIVaI=
X-Google-Smtp-Source: AGHT+IF25fK7DmxXx4cRpaOk/Yue0RcXkRNRheHfNjiXSuVFBCPvk8IHEvmZd7y+sSx143eo+5PDHA==
X-Received: by 2002:a05:6808:208c:b0:3c3:f6d8:dfd0 with SMTP id s12-20020a056808208c00b003c3f6d8dfd0mr6807301oiw.39.1711876777766;
        Sun, 31 Mar 2024 02:19:37 -0700 (PDT)
Received: from localhost ([2402:d0c0:11:86::1])
        by smtp.gmail.com with ESMTPSA id x128-20020a626386000000b006eaa84fdf2fsm5954217pfb.215.2024.03.31.02.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Mar 2024 02:19:37 -0700 (PDT)
From: Alan Huang <mmpgouride@gmail.com>
To: paulmck@kernel.org,
	frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	joel@joelfernandes.org,
	josh@joshtriplett.org,
	boqun.feng@gmail.com,
	rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com,
	qiang.zhang1211@gmail.com
Cc: rcu@vger.kernel.org,
	Alan Huang <mmpgouride@gmail.com>
Subject: [PATCH] rcu: Remove unnecessary READ_ONCE in rcu_preempt_read_enter/exit
Date: Sun, 31 Mar 2024 09:19:32 +0000
Message-Id: <20240331091932.129617-1-mmpgouride@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The two READ_ONCEs here imply that there might be updater concurrently
modifies rcu_read_lock_nesting, although it's true there could be
interrupt handlers enter rcu RSCS, but rcu_read_lock_nesting should
remain unchanged after they finished. That is, READ_ONCE and then
WRITE_ONCE the same variable is not a valid pattern, this patch thus
removes the two READ_ONCEs.

Signed-off-by: Alan Huang <mmpgouride@gmail.com>
---
 kernel/rcu/tree_plugin.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 340bbefe5f65..c90edbb7fa40 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -376,12 +376,12 @@ static int rcu_preempt_blocked_readers_cgp(struct rcu_node *rnp)
 
 static void rcu_preempt_read_enter(void)
 {
-	WRITE_ONCE(current->rcu_read_lock_nesting, READ_ONCE(current->rcu_read_lock_nesting) + 1);
+	WRITE_ONCE(current->rcu_read_lock_nesting, current->rcu_read_lock_nesting + 1);
 }
 
 static int rcu_preempt_read_exit(void)
 {
-	int ret = READ_ONCE(current->rcu_read_lock_nesting) - 1;
+	int ret = current->rcu_read_lock_nesting - 1;
 
 	WRITE_ONCE(current->rcu_read_lock_nesting, ret);
 	return ret;
-- 
2.34.1

