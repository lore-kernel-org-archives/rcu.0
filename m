Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72FD19A284;
	Fri,  7 Jun 2024 15:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717772719; cv=none; b=sZeyQ8+NXxRQ8kL1P7YVUqQyLCg2zyRK0De0kfSExxWmr1iRHcSFj8otnmzVv7PoDvvhIq/hph4Bl4W5DBqdufNvFUtRxoVnVeAsIOmvSSO0qFh0oSprXoo2ZTv+OLS/BKgbn9kCj69eTrfjPw6NQ2deH/DOBjCqfLl8iSJR8Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717772719; c=relaxed/simple;
	bh=lzp9RrGLcphje9tKqdeEIB6pXODtDIlP/2mRhS5elTs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pK28MMx12XkhiPVV6VxlzBnFRMSlc8FlAXNB9O0TlIyai7f5wauPfSpQ4NCvNJV/G44UOJ5MCInUK+lCAi4NbWtk4yrX3pAuoq65lZueJKGtoG8y5lsusZubGji5q1YuY0fF4BGIuk91jNAoVeLP9W7W2tBIB72Eo/CRmbLEVO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EXdNlQsO; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EXdNlQsO"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-702555eb23bso1871533b3a.1;
        Fri, 07 Jun 2024 08:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717772717; x=1718377517; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1IQBttmjUc5XpGJyxQWesF6PULR+7Sc5uHVZnjulosc=;
        b=EXdNlQsOeVIf3miWl8MbhbMB8c1wf9BHQ1/a/eGQWzsVs7uSscQe1GluAEAaHkTvl4
         1WuJWqZMK3/Jv8V/oXDsU9A3L4raPdA8fmT26Qzg7ATz6cWzJWtImHqAPBKuJGfvJcRH
         PRZmOzZXgITRQ4F9JJou5RZV1vSZZM7Da2J9Bf23cxNneiV6oELwSCPZ4v3UKrzEW47K
         zoW7lP8L3QCwZ7fVKwkj+1sx2thzBF3l8erALmqQWApEjYl3hVuPfxhnKgzqQIQq82W+
         AxQwRXmGK3KLyOOIoBAz+vLi9EjK9oF7smMK57CQEKu1p+CGMSkeMR9q8Hl7rrC8YYtb
         iQJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717772717; x=1718377517;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1IQBttmjUc5XpGJyxQWesF6PULR+7Sc5uHVZnjulosc=;
        b=GF3SaNsOz0Jp7KQiaFf0VxSmoAk9lnDPXTrlW8KIqK1ETan1ApP1ZDDfvREFEV04Jq
         YZWw4nbIKDkoWS/2cWsCRS4qlK/2M25EzJrazksDeTfkc05YJtTHXbiGuS51r32aqE6V
         Xaa+ZSf8YhdXLSLjHzULel70FMMwlql/9kuNCl8d7f6NzZq3PrdVOm8GuWnTBNj9F3P5
         JY9MS1bJ8BRbaVIw4to39zO0/0RvXOFixqR7eHYGQF8wG+1If50f0NIIBeOIXhpsUG4b
         24yVrhsfifF9VpHJgILaYfGyd906qv5nNghZwbhoVpkjIyBjXSB2dkIk1nP9e8JoXKtv
         YI/A==
X-Forwarded-Encrypted: i=1; AJvYcCU8Xozl/9JH7+LZnYyb/6b9Evv3kYaXNU52fcAVupsGhDLmtL3bH/W/Gmfsnj2SIdRLl1pYMXH3KL0Ga0SoevfjYB3k7ye1e16M7LqqJeLGefD6csTev7cf3fphPH1vMa8W
X-Gm-Message-State: AOJu0YxTVR7NVFcD3nQvVfVjuAPWBSO5I6dbg4N4cmgqiSxKt7aFs7mY
	skCQrY451oWSpLpqXuX14bkdsegErq55ztQUAw3Onf94c/zGPfj+
X-Google-Smtp-Source: AGHT+IESV2QNvPJQDvL0z19+1HqsJgpaaQr/81akm1nmlmUDp4l9ebDGhvMxbOHzb+WQNDMtMacaHg==
X-Received: by 2002:a05:6a20:5606:b0:1af:ac6c:367f with SMTP id adf61e73a8af0-1b2f9dc2fa8mr2830655637.44.1717772716777;
        Fri, 07 Jun 2024 08:05:16 -0700 (PDT)
Received: from localhost.localdomain ([91.199.84.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6de265a2ce3sm2370500a12.61.2024.06.07.08.04.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 08:05:07 -0700 (PDT)
From: Wei Fu <fuweid89@gmail.com>
To: oleg@redhat.com
Cc: Sudhanva.Huruli@microsoft.com,
	akpm@linux-foundation.org,
	apais@linux.microsoft.com,
	axboe@kernel.dk,
	boqun.feng@gmail.com,
	brauner@kernel.org,
	ebiederm@xmission.com,
	frederic@kernel.org,
	fuweid89@gmail.com,
	j.granados@samsung.com,
	jiangshanlai@gmail.com,
	joel@joelfernandes.org,
	josh@joshtriplett.org,
	linux-kernel@vger.kernel.org,
	mathieu.desnoyers@efficios.com,
	michael.christie@oracle.com,
	mjguzik@gmail.com,
	neeraj.upadhyay@kernel.org,
	paulmck@kernel.org,
	qiang.zhang1211@gmail.com,
	rachelmenge@linux.microsoft.com,
	rcu@vger.kernel.org,
	rostedt@goodmis.org,
	weifu@microsoft.com
Subject: Re: [RCU] zombie task hung in synchronize_rcu_expedited
Date: Fri,  7 Jun 2024 23:04:42 +0800
Message-ID: <20240607150443.2096063-1-fuweid89@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240607062531.GA30954@redhat.com>
References: <20240607062531.GA30954@redhat.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi!

> 
> On 06/07, Wei Fu wrote:
> >
> > All the kernels disable CONFIG_PREEMPT and PREEMPT_RCU.
> 
> Ah, this can explain both soft-lockup and synchronize_rcu() hang. If my theory
> is correct.
> 
> Can you try the patch I sent?
> 
> Oleg.
> 

Yes. I applied your patch on v5.15.160 and run reproducer for 5 hours.
I didn't see this issue. Currently, it looks good!. I will continue that test
on this weekend.

In last reply, you mentioned TIF_NOTIFY_SIGNAL related to busy-wait loop.
Would you please explain why flag-clear works here?

Thanks,
Wei

```
➜  linux git:(v5.15.160) ✗ git --no-pager show
commit c61bd26ae81a896c8660150b4e356153da30880a (HEAD, tag: v5.15.160, origin/linux-5.15.y)
Author: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date:   Sat May 25 16:20:19 2024 +0200

    Linux 5.15.160

    Link: https://lore.kernel.org/r/20240523130327.956341021@linuxfoundation.org
    Tested-by: SeongJae Park <sj@kernel.org>
    Tested-by: Mark Brown <broonie@kernel.org>
    Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
    Tested-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
    Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
    Tested-by: Shuah Khan <skhan@linuxfoundation.org>
    Tested-by: Ron Economos <re@w6rz.net>
    Tested-by: Kelsey Steele <kelseysteele@linux.microsoft.com>
    Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/Makefile b/Makefile
index 5cbfe2be72dd..bfc863d71978 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 15
-SUBLEVEL = 159
+SUBLEVEL = 160
 EXTRAVERSION =
 NAME = Trick or Treat

➜  linux git:(v5.15.160) ✗ git --no-pager diff .
diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
index 259fc4ca0d9c..40b011f88067 100644
--- a/kernel/pid_namespace.c
+++ b/kernel/pid_namespace.c
@@ -214,6 +214,7 @@ void zap_pid_ns_processes(struct pid_namespace *pid_ns)
         */
        do {
                clear_thread_flag(TIF_SIGPENDING);
+               clear_thread_flag(TIF_NOTIFY_SIGNAL);
                rc = kernel_wait4(-1, NULL, __WALL, NULL);
        } while (rc != -ECHILD);

```
