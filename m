Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A791EB19B
	for <rcu@vger.kernel.org>; Thu, 27 Aug 2026 15:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787842955; cv=none; b=SVE34IQ9bvVgyPOhpwnMru4yLl+ExkYt/Q96ex0p5eQXqHk/9Yg67vlPc6c3UIPYijxCIsBCnfoVd/e6bXPRXz/CQXdbagGiCzpGt35WOTcjdvcczdaSKOmVr0I/yhaHufYzmKyrrThu8xJjkA5UPL5m0i452vLmZf4dU6avKbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787842955; c=relaxed/simple;
	bh=mHSuH/RxndBuBlW/ii8l5hypvjBHDV5xR6hyahIPH0k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qyHkglwTqcxKKzNFjVzImHS7rkTKnHUjOgjgtuQ5SzQHkNjdeuwwgjTNLL0P2KwrGz9vunpAcGra/bglUmNDD0z7KnBwkzHdBv0RnAxDScuNdMEUnyXRD6jeDKowReoJ2eoo7fAJ9RAWN67W8xw/PudbXFB/T1aljCRErZvSRtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Os7GNH6R; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Os7GNH6R"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2d560775ca2so19474385ad.1
        for <rcu@vger.kernel.org>; Thu, 27 Aug 2026 08:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787842953; x=1788447753; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=N8SXyjur19MqUQGaIin+lz6Eqqg1k7QeX6LUDFfcSjs=;
        b=Os7GNH6RF3mGgsrRIcRW1ER5N5/kOh0U1MFnknJNzSQWIirihStpPXtGyHdtMLprYq
         ZB429/tFvaltSdYK0GkJpDIOOfeyJluabL6R3mRE+hN3r132bmRNENzphYQd4lGfCRoP
         lHQSFaLrQM7RqKrdENJvNjw7o1S2kY6mRoXzfCabE83OWiKkxrp0v/KD7eIqghjNhe20
         iZLhy+ydJhx6KH5wP3/YzjS+Cbn1EOz08Xg2hkpqJ5sRi8xYgzGk3YsWeAf92IRCRHig
         Uu5xn7wsuYWNUgxvqGNkeRMctkkbFHQoJf82JnWfO4YjZQhb5ika8UhW3cnBjdG55peh
         +CHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787842953; x=1788447753;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=N8SXyjur19MqUQGaIin+lz6Eqqg1k7QeX6LUDFfcSjs=;
        b=ZXTvWeviOhUGx9jmwcofN+FoiRH8Ox01lDuIVr93aKoOgzZ1+Ft+uH6sVKD2L7rFRB
         ee6pBcBgQTS6YGlNEo4m1Ku1Dh4jPO6+QyA4XsxCZeeHuYoXOXFfCNFULvfIQNmVf7eJ
         nS0zbeCBOvuPyMqhRZSLnzuvvd7l/IhEqgaT4vXLkjsFYefgi/6YWr/aWP63N25U7//t
         9mKDCN7ZaX9B3qwyq54B1I6aSCzkUxlQSiHOeXD3xfsKgmU/ir3qx/fUBpBXfxeKIP7i
         r6mBVACGaVfhOUPCH0yaSgPB/RuFSUnY7YPb3318TCkJJPo6A4QTIS8HdHok9MsDGGGf
         GLIg==
X-Forwarded-Encrypted: i=1; AHgh+Rpw6TbYUPlyVo1vBtzvpUrvinQUC2CCn9XCX5uyababDKv5gbL5REX3VylYdn2Qn4CHb4c=@vger.kernel.org
X-Gm-Message-State: AFuF++lmy5DaLYNephQG4LcFY+t3+ZCgSy3kjyCzVA9VrWRVsjxvRodf
	kGAivewsWSo9r4EwBZ/N2EWYr7bTt8S81poQ3NFRhJihB2GKamk71/KI
X-Gm-Gg: AR+sD11R8o5tpKLeq0xNovGpweDWdQZFtQr5yUYH/0dN6BCUZYAPI15uEJ+AznDtNtw
	Y7JJbMg1i8nfuRHuBlwtq+6fCndwXZK41wBju40z/5mC+XbedIBuVHejpwA2qjeNWKLWuWjx2Hm
	1UHeGZThSrWpujPW+9bEZ6g0cB/MNgbDEvonEKWdyJDK0zSm3T69RZZhrKvF3AmnKDYSAQ37p25
	IkZs8MMZCVJ4f22hu2cM76ClcRGPsjH/CKGf+Z0tSS/xwiPJO3ZH2UPRw2clB1QjAAsjMc40nr1
	eO5bw3i+XrPNJhwAb69IMsQSVE4XyS228Gr1KEJLnQx9WHJtqMNLKQgC34l7fHcYztTbS7xK/Bd
	as3f6KSS4PAfxCJWig1q1YPe/4c65KARitNMX380/cSnWIu0SuHEv8d1oJPXKkMckNvjJM85DiJ
	QVd2PjDma0iRK2llswPomWqoc12WNtlI7QgGjhG6sGLbpp0hXswMam/a6/QlhHBJlFfb/eVYZaO
	nBMyrzv8fvqRDRY
X-Received: by 2002:a17:90b:1809:b0:38f:7f60:ba35 with SMTP id 98e67ed59e1d1-3966d199247mr31244328a91.5.1787842952926;
        Thu, 27 Aug 2026 08:02:32 -0700 (PDT)
Received: from shpark-MS-7E27.tailee9dcb.ts.net ([218.49.81.87])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-396b0fa7a3fsm3026999a91.10.2026.08.27.08.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 08:02:32 -0700 (PDT)
From: Sunho Park <shpark061104@gmail.com>
To: paulmck@kernel.org
Cc: jiangshanlai@gmail.com,
	josh@joshtriplett.org,
	work@onurozkan.dev,
	rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	qiang.zhang@linux.dev,
	frederic@kernel.org,
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sunho Park <shpark061104@gmail.com>,
	syzbot+d4faf7db59e11f6fd1ab@syzkaller.appspotmail.com
Subject: [PATCH] srcu: Fix WARN_ON() for rcu_segcblist_n_cbs() in  cleanup_srcu_struct()
Date: Fri, 28 Aug 2026 00:02:08 +0900
Message-ID: <20260827150208.2166775-1-shpark061104@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The WARN_ON() added by commit 78a38cbf6f20 ("srcu: Queue sdp->work
when the delay timer is successfully deleted") uses rcu_segcblist_n_cbs()
to detect callbacks that srcu_barrier() failed to wait for. However, the
->len counter is decremented only at the end of srcu_invoke_callbacks(),
after the invoking loop has finished. Since srcu_barrier() can return
right after the barrier callback is invoked, cleanup_srcu_struct() can see
a non-zero n_cbs even though the cblist is already physically empty,
falsely triggering the WARN_ON() together with a still-pending delay_work
timer.

Use rcu_segcblist_empty(), which checks the actual head of the cblist.
Callbacks that have genuinely not been invoked yet still leave the list
non-empty, so the WARN_ON() still catches callers that skip srcu_barrier()
or queue callbacks after it.

Link: https://lore.kernel.org/rcu/e6350377085ddd85d6ef00d8e9a67bd50c762d3c@linux.dev/T/#t
Reported-by: syzbot+d4faf7db59e11f6fd1ab@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=d4faf7db59e11f6fd1ab
Fixes: 78a38cbf6f20 ("srcu: Queue sdp->work when the delay timer is successfully deleted")
Signed-off-by: Sunho Park <shpark061104@gmail.com>
---
 kernel/rcu/srcutree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index ed204b3f4b84..ad27880dd690 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -704,7 +704,7 @@ void cleanup_srcu_struct(struct srcu_struct *ssp)
 		// Call srcu_barrier() before this cleanup_srcu_struct()
 		// to avoid triggering this WARN_ON().
 		if (WARN_ON(timer_delete_sync(&sdp->delay_work) &&
-			    rcu_segcblist_n_cbs(&sdp->srcu_cblist)) &&
+			    !rcu_segcblist_empty(&sdp->srcu_cblist)) &&
 		    rcu_cpu_beenfullyonline(sdp->cpu))
 			queue_work_on(sdp->cpu, rcu_gp_wq, &sdp->work);
 		flush_work(&sdp->work);
-- 
2.43.0

