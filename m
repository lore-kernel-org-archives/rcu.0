Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793285345;
	b=DGwX97GV+wqufc28JGbPQx4uc+83kj1oWIVn2l9yY+C2srHWJ1UDXAVzLeHecU6CV6eW
	 C2ozo0lMjG8+JzBSZxq0yskpyKZMY1ScWoWothvdq+qV+tT9BKbm9+LTButAJRvT0RyJJ
	 UKiZ6WSaqjD7+Ds7U1YEHJqdamyiXMXto/BI6LGGD3BTCRuP4k+U3Xol4Hilcpo3J+HHx
	 4soPbdSCF3ybdzmHUBk5JXFPR+LZLbEB1K89h2fHXUqLEmX6U+mk0QYVp4GW6PGwxT6mX
	 GC3MmmQBKj4UMtsVCATLKoJv7EA8PcKlbszf2biIkxrqVubMfJwbyKT+/tUmI8DxFYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793285345;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=11yI6X7RNJHkj59+rMm7KEGQ4tLy1r9EmEZe830OAuk=;
	b=sPJClapVdNV/wzMLwIYyHJww2S3yp/clpkcovCVsAbnE8W2N1oivEOGuDUO0veb1djCL
	 7HL06Q6SIAh1g0g88Wwn9CWbW/bJlO0lWxssbsOP8YUOOHozWg8dQAAvczokZFo9kz5VV
	 BuYD7xL7tV1dQrOCAgJvlKA89U+9ef+26SuHOt5hdh055CYQusZ/GxmoAzqGk2XUF+907
	 6jdAO1v16+615UkrwUbOodN2J+5GQy9Z86b8kE3Iy5IEWRoklXHacuTFm5LSpBtYjbaPD
	 FaD2xWL6f1fo6iApdoh3qizl+Gz9DwN/hebwl+rLHM/EnCEeCbM3Vrxm+bmdP7OOOWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0TeGZj1R;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D96606A31A
	for <rcu@vger.kernel.org>; Thu, 29 Oct 2026 14:49:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0D96606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0TeGZj1R
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a35d5d4a20so24624185e9.2
        for <rcu@vger.kernel.org>; Thu, 29 Oct 2026 07:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793285343; x=1793890143; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=11yI6X7RNJHkj59+rMm7KEGQ4tLy1r9EmEZe830OAuk=;
        b=0TeGZj1RI2pN5ABAf4mEdDDeNwNE7CrId/GUs9l/thGCPn1vFl28WjdxxCcyeimOI6
         8+z3KRqsr8f7VU+qYRmOMTypLTMPdAoJwdVWhgUM1KiotqdCnmTeglgTYWBYoYd9DvKl
         191H31PcMqXhntcOO2497/3eGiPerhVU/liztQ0LUbify1L9H98xjU2vdE3m1rgenuT/
         nzSNN3RtRc2vTN4MkoXvjxsUo625Di8BQN0z71E/Zzma9SMsyHdx9MLRKpdiXttoVtru
         y5Xqf7y/mDIkJYVMmMQgy6OCMyh9I6dwFkdR4aR6t2g6e/xCHDBBdkbPThZ1IYAUWebg
         Nt7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793285343; x=1793890143;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=11yI6X7RNJHkj59+rMm7KEGQ4tLy1r9EmEZe830OAuk=;
        b=cPvQUEiP+sTdIEdoXfzP0fnJuJulpk+QnYNEPQRU8BUjOfNW3Ffq5EmrUeljkdVfJM
         FQOlFevi0ZKmVp7UV+rE8gZlFcE/4sDiEjmtph4HMQcnrc8CB/E/ZBskDlL2BifJGZgx
         3iplE57egAym91eMtoKppAOYLlGPjZCfim88HaK4S2nnWjkpeSV2nOo+WBGisjGPiY8X
         NuyeLpXGA1QWmz8o0v1LXIIKQ9ZZkR4A+QyQDOrckhRKV/QUGi6w1zC7+C9N3ec/Aken
         6nG5KMwgG6BmUM2Nx4eP+8nSnNrSkk6GhgXpUlipTZfayOLsrrlgmxBeONM62iL4REIo
         wTwg==
X-Forwarded-Encrypted: i=1; AKwUvBxdkxvVAy9e7aHpG2NIJE4rxci3uzxA7AdLmDF7Slgm1IKb5WSt7uGr5EPxaOrVdlPdpWg=@vger.kernel.org
X-Gm-Message-State: AFq9FYKg2qdF2H1UtJ5ECmWqIB41ASi0m/JgCgB9nbDjj9M8YCMEjtcY
	bPzFezvLvcv48VGkXJbzwQ3kP8yqfAcE4/XneswZpS5f2Nq1tDLPYSBF
X-Gm-Gg: AYBFou3s3wzPsSJnbMfxASd53WtsSMOBUhdkmt5Jw6zlLBiMJPrAYjiJxH6HwQlBan9
	rvK06CmkapmYR4OMccWUU5Po+ODmPsgippXegbAp5feD9g3JDjSr6YRBcJ2egUZckPJ4c4NmUPo
	+DcC5dnfE3cc+vuqdjM6z76+PCsMxjp9hTDc1Jtv7Jw9YkTCc+YhOk7zvcXeicB6nMqSree1TxE
	6LwZi41BfBXm5ILlo39b3zNi0gtEUcAwXAKlxHQkH5H5phpDwPnNCujQLmIc/o2YjJW/IoT8Qi9
	hk7vHbSg96Ql5QcdBlCXBlvfBiFzlbje2ycy2Ay3cHaxqAP8rms0nzF/oNJmikgbQgL7goeXQB3
	uLtfvGyCgrqqr4pQgnsaKTTgpzme7mdxb6RznZCi706QAAtTCbo3+MWIQoGeNk1ND9pO2XAFkxL
	uCo+mUGkzeWQSjZYlBK8OWVZDgn1wLOzpZseSo1bX4nukunUlUiErHR5mZdaDF2DObnrD4Wufp2
	KF8Wv8Vpq1K2rZX7GBxF6SOIxu8/CWV2RFunqcvdVYqpgCYXCT26A0yXBeqiP0cr6reUOz4bvo0
	VH7iQYyvRuhwQ/w7cHDev0QPdCBPLp535BEAOm/Qwh3xCZdlS5002OdhcU5V1V3KgVmZIhn11fe
	JhjXH
X-Received: by 2002:a05:600c:1d1a:b0:4a3:59c9:a747 with SMTP id 5b1f17b1804b1-4a966c4111amr126768575e9.17.1793285343088;
        Thu, 29 Oct 2026 07:49:03 -0700 (PDT)
Received: from andreayoga.localdomain ([151.57.246.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa7f322c46sm66634665e9.2.2026.10.29.07.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 07:49:02 -0700 (PDT)
From: Andrea Parri <parri.andrea@gmail.com>
To: KunWu Chan <kunwu.chan@gmail.com>
Cc: Andrea Parri <parri.andrea@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Gary Guo <gary@garyguo.net>,
	Bradley Morgan <brads@mainlining.org>,
	rcu@vger.kernel.org,
	lkmm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH -rcu/dev 0/4] hazptrtorture: Fix shutdown hang and catch slot owner race
Date: Thu, 29 Oct 2026 15:48:53 +0100
Message-ID: <20261029144855.213308-1-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CAN_Opa8OyyuveYo7VyfQb4rDtUmw_m-25OSXSqwpzfOnGqwEpQ@mail.gmail.com>
References: <20261027163811.2470569-1-parri.andrea@gmail.com> <CAN_Opa8OyyuveYo7VyfQb4rDtUmw_m-25OSXSqwpzfOnGqwEpQ@mail.gmail.com>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Oct 29, 2026 at 05:58:27PM +0800, KunWu Chan wrote:
> I ran into both issues independently while developing new shared-scan
> hazptr series and its torture-test scenarios.

Thank you for testing these, and for the arm64 data points!

[...]

> Paul's concern about `torture_must_stop()` is valid: `fullstop` can make the
> drainer exit before the readers have stopped, so its exit-time flush is not
> necessarily final. The reader-exit approach looks worth testing against both
> the forced-slowpath case and the PREEMPT scenario Andrea reported.

do_pending does leave its loop then, but v1's for_each_possible_cpu()
pass comes after torture_kthread_stopping(), which returns only once
hazptr_torture_cleanup() stops do_pending, after the readers.  Either
way, I have been testing Paul's suggestion of a pass after each
reader's loop, without v1's pass in do_pending.

[...]

> These tests independently reproduced both issues in my setup. I'll check the
> final cleanup approach against the forced-slowpath scenario as the
> series settles.

That would be very helpful, thank you.

Thanks,
  Andrea
