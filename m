Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2AE40DFB4
	for <rcu@vger.kernel.org>; Mon, 30 Mar 2026 11:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774871212; cv=none; b=ZCbzDA9g+RAePmBlEM4C5XHMG37bz1caP3jAEathTiJZA1vQ6nZtEwOj42HNTR1qTHSyid6IiXMKGYa4pChTM+0i9G6XcqlHqE5xJ1RcOfuYxh0LtrZhw+sLJ148Gms0hhTS9E1HTUQmNeq3v7yeSNY6NFGErLYQ4R+JazhxCko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774871212; c=relaxed/simple;
	bh=NL8trraTtD0OpTkWQqnsyUPcWRWAvLDDCm/yybFJDGA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pEtkuT5yfQd9QS6moYIyZTzMNOD9BWGgREupKPoqRDi6tF+Uqm74oHjFmg3HdnOpMYPF3kP99c+rOR6nFVk/2A7+CGsHgMbRqIUMEWwmLKdKuqyDM+PrsER2JmdUMCOg1Ki7UFxbejKTfqMJSIR1oVWpzDf6myzVW6X13Qvpeh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IHfAFMPQ; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IHfAFMPQ"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2c160cb021cso4197652eec.1
        for <rcu@vger.kernel.org>; Mon, 30 Mar 2026 04:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774871210; x=1775476010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eML4waLa1Jl6y2CJpXYjrV0+SpUpnkgbYk+PFVbKujU=;
        b=IHfAFMPQa2UkHnwN5HtXTnEJHlCyBFHtJhbg/fqYG9RKMP0H9r4Wqb2qnmHMLm5h1g
         Kl8ZBmXyNNJxVGjMfWWckKfHdaHSCT+eODL5/Ovq3OpBztLfVwgdHAKtCxaY4PgxOwMB
         eDnVxr2QWgL3TfTDGUfr3Me5tWybpCrSTHYKZ2FG3F35SLhLoUTqaIs5bAL6nM66WkSU
         GgVI3/O8KoUDQ4sKRbURty2x7yIedY7nIDQTdAKulyxpOkztwYNDtDN0bhfraVT8Darg
         2MkaYnnmEg/VdpW2urqn3V7+Cbj1w4F/ieFl6Vk9PXZWYcegrfyCOxlWRZNSuW7tCNQF
         QuBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774871210; x=1775476010;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eML4waLa1Jl6y2CJpXYjrV0+SpUpnkgbYk+PFVbKujU=;
        b=XHn0lueQiMA6sPGcqRt77wInLOyoI9h69T27kILGzN7UbgDIqK6bjTzRvfSfXD6CMO
         ApqEzZba0a3crFBT4Ncg4jzsK/wFDjpoO/1LgtPcrysxzAEnmYNWgzyGIHjQD5yX7sbK
         /j/W25FQuYmNwYUuFh4bOPUdqacUbN2roqxlb/dUvFI5viPA6Ngag78TNUOgg+M+eDeh
         csi/AVpEL7oVbtL8w5NNe9t7Tn/+vZlQsPr1NvHmsrdZQXn1QFrfJ1wS56i+1BnvA9SL
         ez7L8ZlEgASsGZELG0ba9tlrukduq2SOwus1k6DaljGl2G6HTztOXCG5eV39+1v125eC
         3hRw==
X-Forwarded-Encrypted: i=1; AJvYcCXw5i7SxRfFC8pn8t8ouUCVXcG937iSRnJkFVYo9WZX+1tGuWq74VnYQw8x9GBdxHgYrvE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrsizYhRgNNN9D3yXjx1+xHYi/Z8VsbLOCuxqmnl9a6liQqKim
	BBIjGYLlb1+eNXSTY2c/Tv2MvV3Uspalnz2xv5LR6fDqde1pf8ux0oSa
X-Gm-Gg: ATEYQzwPw4cZ3VVcPmhX+FXe2ba8FaEnoWt97YMsB+4hprMgSq+9LuTW+AKQ4PeP2Fe
	ZjqJCUUHT9iKRJOHYDOWFKJ+CsY/aXhPSKl1K0wuy7ay2naFIl6HGB/G2X33V+mKCoWgHlRk9J2
	rwlj4TnACNXb72sGZbjzF3rdJXjCxTLr1mMJXtPbFNRoJSGJ4rZEe9gQepAZX1MMjE109htx54o
	Cq8gDm9lAcHi9cVDuffzNPu/604sFrzKmCG6z9Qir7RoQbSo8nJsLDA00kp65OCJSoDGoNzKuvo
	kgygBdrkFad5QuGYUlgDnCmloMJIStqzR9WrvbX4hXzq6qO+3tPxwB/+Bb5zQJqw77ZWAB+kEed
	cxyenUtzpqRwnLLQfUAC7ZsjmSZpcX92xaODBw7FkCvKwIVJ1KInbxoPS1lI0kSbS81noOee9BC
	FN399PjIUh4OWwz1zB5FBgN+JxMWezj51vgSk=
X-Received: by 2002:a05:7300:fb8d:b0:2c5:3b87:2ffc with SMTP id 5a478bee46e88-2c53b8732c9mr2663188eec.7.1774871210414;
        Mon, 30 Mar 2026 04:46:50 -0700 (PDT)
Received: from localhost.localdomain ([74.48.213.230])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c3c3bda147sm6869724eec.5.2026.03.30.04.46.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 04:46:50 -0700 (PDT)
From: Qiliang Yuan <realwujing@gmail.com>
To: peterz@infradead.org
Cc: longman@redhat.com,
	cgroups@vger.kernel.org,
	akpm@linux-foundation.org,
	anna-maria@linutronix.de,
	boqun.feng@gmail.com,
	bsegall@google.com,
	dietmar.eggemann@arm.com,
	frederic@kernel.org,
	hannes@cmpxchg.org,
	jackmanb@google.com,
	jiangshanlai@gmail.com,
	joelagnelf@nvidia.com,
	josh@joshtriplett.org,
	juri.lelli@redhat.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	mathieu.desnoyers@efficios.com,
	mgorman@suse.de,
	mhocko@suse.com,
	mingo@kernel.org,
	mingo@redhat.com,
	neeraj.upadhyay@kernel.org,
	paulmck@kernel.org,
	qiang.zhang@linux.dev,
	rcu@vger.kernel.org,
	realwujing@gmail.com,
	rostedt@goodmis.org,
	shuah@kernel.org,
	surenb@google.com,
	tglx@kernel.org,
	tj@kernel.org,
	urezki@gmail.com,
	vbabka@suse.cz,
	vincent.guittot@linaro.org,
	vschneid@redhat.com,
	ziy@nvidia.com
Subject: Re: [PATCH 13/15] sched/isolation: Implement sysfs interface for dynamic housekeeping
Date: Mon, 30 Mar 2026 19:46:20 +0800
Message-ID: <20260330114620.104027-1-realwujing@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260325140432.GE3738786@noisy.programming.kicks-ass.net>
References: <20260325140432.GE3738786@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, Mar 25, 2026 at 03:04:32PM +0100, Peter Zijlstra wrote:
> Why? What was wrong with cpusets?

This is the central point of the architecture. The distinction I was 
trying to address is:

1. Task Isolation (Current CPUSets):
   The `cpuset` subsystem (especially `cpuset.cpus.partition = isolated`) 
   is excellent at managing task placement and load balancing. It 
   ensures no user tasks are pushed to isolated CPUs.

2. Kernel Overhead Isolation (Housekeeping):
   Currently, `cpusets` do not manage kernel-internal overhead like RCU 
   callbacks, timers, or unbound workqueues. These are managed by the 
   global `housekeeping_cpumask`, which is settled at boot via 
   `isolcpus`/`nohz_full` and is static.

DHEI fills this second gap by making the housekeeping mask dynamic. 
However, I agree that a parallel sysfs interface is redundant.

In V13, I will move the control interface to `cpuset`. The root cpuset 
will serve as the primary interface, allowing changes in the cpuset 
partition state to automatically trigger the migration of kernel 
housekeeping overhead. This achieves "Full Dynamic Isolation" (both tasks 
and kernel overhead) through a single, unified interface.

Best regards,
Qiliang
