Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28CED1E505;
	Fri, 30 Jan 2026 01:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769736645; cv=none; b=YehBYzaX6uGsBJo/9dY4rmXSUHhnLYhZyuoX2Q1qlgt1Va7joFmkw4mV+ANUCOgau7EVmoOCw6EwnwMBb2xNLZV21EEsfo3cMklXoqFLuFjXTx+NlFvPzUGdMTSHdau9XtPdW5j9DjnfCms4e+bhtzZbMAxidbIak/BzqLK3VIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769736645; c=relaxed/simple;
	bh=OlbIY1iyiqrtSFOkHZza6Io4EhPQz9j1A+bmxl8z/gw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=gKB9bOmQRbW+gcyK/jU/hJPSXkMOFtgnDl6tGvlQYaq7rHDp8qvAJaqRQfNgP5O655j0f4hOGPAt0KcEDSuo0MY88/SUrwIvH+syBc4azxAMA3+gSAuSFkKzwZY++VFq6YUJlSTbx9uKwSk+JsIRBgxA3dhaQdYCSOS2XRaIxlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HgCIg8pv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HgCIg8pv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93CF7C4CEF7;
	Fri, 30 Jan 2026 01:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769736644;
	bh=OlbIY1iyiqrtSFOkHZza6Io4EhPQz9j1A+bmxl8z/gw=;
	h=Date:From:To:Cc:Subject:Reply-To:From;
	b=HgCIg8pv0gbrfouykuJ5fk91Ebam7hEIaXvEM3JrKnGuFXoHb8vDpXYESYqUZAFGM
	 3PTlcaWnMTkWFbEpEM/leXTYrgDq6S9nGGW2R10/CZdg8RBuzOAI6/exbtXVhQqrb+
	 TI6nnJYf27WUIQDbqQR3xpzaMt4I0nQI/Piz5BEoQoEIz25XdrHwQ4x3POdX2GhUdq
	 +dGr57u+Q/odwT1O/31fg2PcIJ9RqIiMxUXiqsijzLWZ3o3sZdF5YKuXdTRFIr1eox
	 lIHNdctrhWqAWTx6qTPlt4l50mCi65TH1wDJIEAUPtzs7qH3tBzlIQLfWHp/3xSyZF
	 oFprhQWfvtyMQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 34AD9CE38F0; Thu, 29 Jan 2026 17:30:44 -0800 (PST)
Date: Thu, 29 Jan 2026 17:30:44 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, rcu@vger.kernel.org, bpf@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Boqun Feng <boqun@kernel.org>
Subject: [PATCH] srcu: Fix warning to permit SRCU-fast readers in NMI handlers
Message-ID: <8232efe8-a7a3-446c-af0b-19f9b523b4f7@paulmck-laptop>
Reply-To: paulmck@kernel.org
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

srcu: Fix warning to permit SRCU-fast readers in NMI handlers

SRCU-fast is designed to be used in NMI handlers, even going so far
as to use atomic operations for architectures supporting NMIs but not
providing NMI-safe per-CPU atomic operations.  However, the WARN_ON_ONCE()
in __srcu_check_read_flavor() complains if SRCU-fast is used in an NMI
handler.  This commit therefore modifies that WARN_ON_ONCE() to avoid
such complaints.

Reported-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Tested-by: Steven Rostedt <rostedt@goodmis.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: bpf@vger.kernel.org

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index c469c708fdd6a..66ba6a2f83d3a 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -789,7 +789,8 @@ void __srcu_check_read_flavor(struct srcu_struct *ssp, int read_flavor)
 	struct srcu_data *sdp;
 
 	/* NMI-unsafe use in NMI is a bad sign, as is multi-bit read_flavor values. */
-	WARN_ON_ONCE((read_flavor != SRCU_READ_FLAVOR_NMI) && in_nmi());
+	WARN_ON_ONCE(read_flavor != SRCU_READ_FLAVOR_NMI &&
+		     read_flavor != SRCU_READ_FLAVOR_FAST && in_nmi());
 	WARN_ON_ONCE(read_flavor & (read_flavor - 1));
 
 	sdp = raw_cpu_ptr(ssp->sda);
