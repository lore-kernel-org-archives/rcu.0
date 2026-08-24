Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4349B40800D
	for <rcu@vger.kernel.org>; Mon, 24 Aug 2026 10:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787569007; cv=none; b=QkwjsJhfQNvhtaDU5WNBO9+kjNe59o1mLioKxh5tZYLP3C5D8jXgpwYn/KhwxgtZv92vmjdQMOePaS5wvXBAiPh4/SbHl7Pg3UpiR2dQqyl8h5j1ilcA+KzYHk1U3/JotVoUcI0gxAcrZMvJINCEdcZ5CG8FUsPD+j2GP3O2+Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787569007; c=relaxed/simple;
	bh=HAVhEo41ftBXk2eGrSZviX7ckEMXwirfUSQXIvaJGVw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EmcZoz1ZSVVNvxHQ7IGBSqkcUliIC91fcO4DNPf05gVehUE6jClm2v5EyCKeMXXzRlZ/rBgJuOmm4QdIzvllpKk/jPOsbAqmCgvOXMl7Pm4sUv0c6C5BvRaaxSJzBZNP+32S4uvhxoySjsy5TF2z339TmuWZjI9cpL9MFxfgD8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PM2XTxns; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PM2XTxns"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-84faf87d19dso3245761b3a.3
        for <rcu@vger.kernel.org>; Mon, 24 Aug 2026 03:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787569006; x=1788173806; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=HAVhEo41ftBXk2eGrSZviX7ckEMXwirfUSQXIvaJGVw=;
        b=PM2XTxnsESdIsfjOTRga8vtAz3QPD2NeF9gStLX2lj+Svxb5Av8yKMWpoA8z2WVr+/
         EjbLC5ZHr1h/56WCAi3HXuovn+n7cBNFoAIJj/FPXB4RmkJhgo0o9DLM0CYGzE86VHnI
         w7nlM/ZkmfphsO0GPWBBskDSWgWuwnXf4zRh881W23d5FQsehkZMeUL32qUJVfaLp6U7
         b6tDhnU1zDZNxbsQSeMg3mg5Tg3PEqJzwjHjx9N2KvcQAuFPa2L547Gfd6nmH4QXFZx8
         S+6i3lvt1vl86hN4s/i4TxS3bmnb7CH0Hp/pIYs0m4oduTanBSimT4sf0tXP4cp76plT
         j+qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787569006; x=1788173806;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HAVhEo41ftBXk2eGrSZviX7ckEMXwirfUSQXIvaJGVw=;
        b=BMrm9qUicf4/c/J6uA8rm365Rqb9/E0WEFYQbv0G6TtlmvtSeu5M5Rgpeoea/o/rJu
         fbFohP1o1V1rcTRz+j7uw4H5wJquIasPnq9MRoHWcmjKlf9mokd/3msPfuACUqJPn1Uy
         BU38xtxlFioKbQDIN5d5SkWplzPgrmceSJLoV6I6k9PlBTG18ldOBOeN/Js1XB/hzUOf
         GWNJkfnqLk0H9f9ZP6MZ32N7ZwkQ/5A+6EKSDhBSLgvaTQwErfgNo1NlSWUz6rQpRYh8
         xAWP+zUmylKnLUGZUjxvajsAHK+FHU00zQ/40IyPwpXbq1SF5mKRsfbaNfvPeeDjv4Ui
         A7iw==
X-Gm-Message-State: AFuF++lcgiLuo0UgUlPwHoDXTxKtAP1cFA6PqjGscdNDrxLBUPHkgn7H
	jZtetVZibVxSWDyAlsUl+/prqHYwOzfb16hfaXrnAauFKiChxkFGKsdd0pirW7WCZbw=
X-Gm-Gg: AR+sD10bPt2oHNbNMelYN9U9SHNzehekycfj7XycDe4fY7T9hVT/ythiBm3Ue5gNu02
	E5D+W2zY+5g7IKhK3A5XSKiM9ZOIY83lYUPZrQ9U3QCdjB0oO1tiF6SucdskaxiJMp5I2wR8G60
	P4/uI989jZl0ox+VWCJTEZJP+A4DNzVzTJoQWNieuexpQX1EL+EBeBZ2aoMFSIpaWzKgHb3gTNx
	kh3+5RDT7CAfIf8p2qbxirSh4jh+GhOKa9T12SO2DNpjrlaNXs/1ENnUwDKTTNmRpIAYAN2zmwk
	enLQgUKRjktZ5NIymvGUP7rLGk8GlncG/VZ6bxL51HZcxqPZYd2a5LlefIzvp5r0GCC6dOy9xzR
	f8kOjASHEwudtP8hcayW2708uXnG6FRprKI/mMEPo2/ZaNO7a6h6JQH04yQlaqem+yA8Daq+TCI
	9cz+2UzlcKzsG5WAB1dDI3CJ/WxrwuUpYgN2rCNAgjxA9iGcB3QvMBXkFuiHkMktSNRHygN6jir
	AknI3oN1uvJA9K/+Q==
X-Received: by 2002:a05:6a00:300c:b0:848:4859:a45 with SMTP id d2e1a72fcca58-8520b96630dmr32205642b3a.2.1787569005520;
        Mon, 24 Aug 2026 03:56:45 -0700 (PDT)
Received: from shpark-MS-7E27.tailee9dcb.ts.net ([218.49.81.87])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc199daed9asm913911a12.5.2026.08.24.03.56.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 03:56:45 -0700 (PDT)
From: Sunho Park <shpark061104@gmail.com>
To: rcu@vger.kernel.org
Cc: paulmck@kernel.org,
	qiang.zhang@linux.dev,
	linux-kernel@vger.kernel.org,
	Sunho Park <shpark061104@gmail.com>,
	syzbot+d4faf7db59e11f6fd1ab@syzkaller.appspotmail.com
Subject: [BUG] srcu: false-positive WARN in cleanup_srcu_struct() after 78a38cbf6f20
Date: Mon, 24 Aug 2026 19:56:25 +0900
Message-ID: <20260824105625.3725157-1-shpark061104@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The main crash report [1] which is tested on non-merged commit 6b8c8af514d7
is caused by the single-condition WARN_ON(timer_delete_sync(&sdp->delay_work))
in cleanup_srcu_struct(&kvm->irq_srcu). As discussed in [2], it is a false
positive because irq_srcu does not use call_srcu().

However, the merged WARN_ON(timer_delete_sync(&sdp->delay_work) &&
rcu_segcblist_n_cbs(&sdp->srcu_cblist)) is also triggered in
cleanup_srcu_struct(&kvm->srcu) which is called after srcu_barrier() properly.
Although my syz test command [3] failed to reproduce, it was reproducible
in my QEMU environment built with the .config of the report.

I found out that the return value of rcu_segcblist_n_cbs can be nonzero
even after srcu_barrier() because of the srcu_barrier_cb() that srcu_barrier()
inserts at the end of the queue. The length of cblist is decreased after
srcu_invoke_callbacks() finishes invoking all callbacks in a batch. But
srcu_barrier() may return when all the srcu_barrier_cb() are called, bringing
the counter to zero, even if srcu_invoke_callbacks() has not yet decremented
the length. So checking cblist length before flush_work() is inaccurate.

By the comment of srcu_barrier(), it guarantees that all the previously
registered call_srcu() callbacks are completed. Therefore srcu_barrier()
did what it said, only the length of cblist was not updated. I think there
are two options:

1) Not to check the length of cblist before flush_work()
2) Make srcu_barrier() guarantee the length of cblist is adjusted when it returns

[1] https://lore.kernel.org/all/6a78d191.b50370da.49fe0.0042.GAE@google.com/T
[2] https://lore.kernel.org/rcu/01484cd339ea024dd7c01f02a9781f00e67cb52d@linux.dev/T
[3] https://lore.kernel.org/all/6a8bc111.91706f20.16b6e3.02cd.GAE@google.com

Reported-by: syzbot+d4faf7db59e11f6fd1ab@syzkaller.appspotmail.com
