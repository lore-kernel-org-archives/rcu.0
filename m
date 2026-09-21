Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10810306B1B
	for <rcu@vger.kernel.org>; Mon, 21 Sep 2026 03:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789960396; cv=none; b=MPycWmBMNwJV82aA3eonxbhwyUyP3a0NECo6kE7eYGLbRwI+lKt8jpJnxCIh96CrlvT+b5l7hsHcujCaNWujhiCEYMQL1KvstWIGa2ABJwCtnSM8K306CD5fx2KzrlFRYmqGHcuMYzbtf+nFw2P15mf+0XoQNvaXK+7bkMwAXjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789960396; c=relaxed/simple;
	bh=BqleptVklrKDlBDiMIxc39mrkLR5WeFDG+U5RgU5tt4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Br5I1YDMKhrQO5ldKpSKFiflWLB3feZE/TlmqCi2zkKRcM23QF/2Fmrjy1Zu3l97C0mP9MoUI6rtYehYA8mJ+1tzbdYMnq6UXI8qAjuZQ8B7BAnTV6n9ueYzsid8iSOoh1Nn7vKhbSIj/wHRCUbAPElZkAqOxq943OGJTXXaFaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ApjFuxfg; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ApjFuxfg"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2dd68a16955so32943615ad.0
        for <rcu@vger.kernel.org>; Sun, 20 Sep 2026 20:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789960394; x=1790565194; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BqleptVklrKDlBDiMIxc39mrkLR5WeFDG+U5RgU5tt4=;
        b=ApjFuxfgeXDvSmKLCAKv3zcFRV4ItAt4okFUanpI9poC2FwbaRda8HYUlqPdWDHE6m
         q551rDo4oeWfwxzTERi7j6T4fGLHR9Y/gQ9yXUHYD2xsuHwORdhQVpLJUtFTPu4fzFUq
         PJjBjC9ER/v92mk6F7KiyAmxgbGnJ5kGgh3YynPwDr7r1B4OVzNEfuvfWfmYx5awhuPK
         jn2TtFXoYlw2cDg+BXkdzBBKmmm1DCVh58Z+LJ9XQ9oFUX6TvHIJmNEPif5VmM1oC751
         53nVF+E1RLqQp+cHxz5l2eW94e8UVHVFJMEM69z4CK4H+xcPcK8mjBDnA6yNDib/LFhp
         afow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789960394; x=1790565194;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BqleptVklrKDlBDiMIxc39mrkLR5WeFDG+U5RgU5tt4=;
        b=aCuIg3EwhrRWAtaVIlpfIEIZ/62eV3bjPTZPUmkuAYM92CE1gtizXJw/jhucQmYapV
         0wLCHsdQVMqd9bjiZ+B9Qbc3AXS3l3ZdIc5vc3Nm0MqOGvajwFsyZaNPnprCqN90H8Yu
         N1+jYwdC8RKG+jr/CmTJWC37AAAajGzE4OYcAhNeqLS80Qb5AJ0xtSRiklFuB26v9ASP
         gLr6jjdnAVyaBnzVVJNgx5sFFp7xSt0lsXZBHZm5lP0Qx3UU3g/7tAbLxbU+LtX8Y7vU
         PqX+HIy0KqqAXEiWB2uYN8Vak4rfkZS0dcumXUn/3pR11xQ8wN3iNxTTBYI9HOrjmEkJ
         e5lg==
X-Forwarded-Encrypted: i=1; AKwUvBzsDk43Oy3a2Y9JcwJF0EbkSGZZTs//22NVtl2oyS9s44GIeSfFfoY5mA9d1n5ZTEn14p8=@vger.kernel.org
X-Gm-Message-State: AFuF++lB3/+AWT2zEQRsyQb0O9ix3RhzGCnVKniuWWQliBDjkTIumIOV
	oe3HpE9CN9/HRSW6xica+sMx/np06qdRiF+VzPoFNY0OXUoLl23LtlFd
X-Gm-Gg: AYBFou3aojs1fLX55VDFfncD45B1MGa3aakx2pnVBtoUPkQhKly97TkxDDuW0fuV6j+
	1c5uRzdW2HinoyDqNyk/lCBu4adldKVSanj80FhcNsxS59QIx8W2bCeadevyqpZtlz3ICO8Fflt
	VjahpKc6I7zdi+5woFlYgWBzcQH8K5GWVLKona82x1IeSXoSmdMufEwqsoa4LE/9ltZ0M3etbtC
	nqh2Ojw+atm/ezf/L6K4ePCle6/6ksk0yjQjSHnrDa+92g+bUn8z6yKOaFQP0g0U72eW6IBKUsO
	lq8yfj9ucbwDgsV1jB1MeumZQ0r3veyxdGAcUBjiuexNesc3/nFxSE8KpOSAjdM27RAKrq/zCKv
	R/HjNHrbFLNBLdNF1MDWwNveELWGp9WwMBAiJUtCyrEN18/fiu/1Zq7P8s5m6nqHmeyoVT9KGwc
	8xoYgqDnWAiD6to7XvlPtGQtZtN2arkEM3WGIS/xO/A3cUZXr1UcRnodNimnzzKZQ=
X-Received: by 2002:a17:90b:3a4b:b0:3a0:25f0:d898 with SMTP id 98e67ed59e1d1-3a025f0dd9emr5480440a91.47.1789960394342;
        Sun, 20 Sep 2026 20:13:14 -0700 (PDT)
Received: from ubuntu.. ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33c3313d907sm14845766eec.11.2026.09.20.20.13.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 20:13:13 -0700 (PDT)
From: Jing Wu <realwujing@gmail.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Tejun Heo <tj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Shuah Khan <shuah@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>
Cc: Jing Wu <realwujing@gmail.com>,
	Waiman Long <longman@redhat.com>,
	linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Qiliang Yuan <yuanql9@chinatelecom.cn>
Subject: Re: [PATCH v4 00/11] Dynamic Housekeeping Management (DHM) via CPUSets
Date: Mon, 21 Sep 2026 11:13:03 +0800
Message-ID: <20260921031304.437934-1-realwujing@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260710-wujing-dhm-v4-0-2e912e5d9645@gmail.com>
References: <20260710-wujing-dhm-v4-0-2e912e5d9645@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

Gentle ping on this series - it has been quiet for a couple of months
since v4 went out, so checking whether it is stuck in a review queue
or just hasn't been picked up yet.

For context, v4 rebuilds the series around the CPU-by-CPU hotplug
cycling approach that Thomas suggested during v3 review, replacing the
RCU-swap-mask/callback mechanism from earlier versions. Patches 1-9
cover sched/isolation, tick/nohz, context_tracking, watchdog and the
cpuset driver logic; 10-11 are docs and selftests.

One thing worth flagging: v4 deliberately does not touch RCU/nocb
offload state. That piece is still being worked out in a separate,
ongoing discussion on Waiman's nohz_full/managed_irq series [1], where
the open question is how to change the nocb mask without paying a
stop_machine latency spike. We scoped it out of v4 so review of this
series would not need to wait on that RCU decision - happy to fold in
RCU/nocb support as a follow-up once that discussion converges.

Any review, even partial (a single patch or a design-level concern),
would be very helpful at this point.

[1] https://lore.kernel.org/r/20260709023221.634684-1-realwujing@gmail.com

Thanks,
Jing Wu
