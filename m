Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F683C7DEB
	for <rcu@vger.kernel.org>; Mon, 30 Mar 2026 11:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774871118; cv=none; b=fSxGMCVAPNxbuD0+qZR2Gc+RF+XxSSQLeA6/cdot73kh3BK8hTneptm0hHQhiayJB9TkTpnlLfXlpVkB1NuToXskkJ6rmyB3Hj4goa5gAP5MEUseN1zw2cX68u2PpDDX6B5RBqy3nnv4kO8jxpDRc29nzRuzfrspsFd1q37xAZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774871118; c=relaxed/simple;
	bh=kycga9i6Vn45DHzFTlgg9Oku8LYokhcIRIuU+jvkYqc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qTby4/D9EyGbIeCl5AWUTM/wiD5DpMnf/erFdI3LJBFEK0KJBAaOItCwNMDCqR27HK9slnVA2Njb3oranw3uFvTOUv02fRQgnf4vJ/hMpM4pc3HFsJ0leJqMqcbWUX89hDkCQ98LgDD5G7k7rDCGIyyhw3WPUS10MElCOtE77/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q9hIlR57; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q9hIlR57"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2c0c955a481so723476eec.1
        for <rcu@vger.kernel.org>; Mon, 30 Mar 2026 04:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774871116; x=1775475916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kTACHKzRTTQTHv2BeEVVc+PV7wXJkipQOVm/vndnvSM=;
        b=Q9hIlR57opwLzxLoGOaNh4LiKBiKNdV44IqEoRdMuyK9MmIv58Tlbr8fxcoXZA8KHk
         cTh5YniRvEhyEhHgtyetXW+QyAoOGRvX6pTJ66pgIhshkYwyM86yke5foR6ecdMuDCOE
         CnkSMQnOn4wg9+pgvJg5hoc01+1FtDML7C+9gssrI/vEYkrM8Y30byoq0Z4mBIoMOsnX
         KtXHRLTwQS7PtLIaa2QGsuOSof5hQ4boXtV5QP/wXRfo6URzKh1oWugkvJ9QzILD4RzM
         FnZa7hBMLLfI3YUmk6MBfAKXNC0jE6j/VWK/mb9uky91MnvZRPuAP+T9Kk31xczm18ao
         hZ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774871116; x=1775475916;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kTACHKzRTTQTHv2BeEVVc+PV7wXJkipQOVm/vndnvSM=;
        b=qZbA7M+zSAIcSWqRpKmO6AII0QDSu7UBLkl5NuNAd9PCtZ56NpiW6E//dJgXO/pmq2
         5MjzgnZ1JQ8wMlfwCzQo/qj5WDCEERFFGfY2Z+c2PtFSjpOpWmTCh1ziGRLsNryG7tXJ
         nTYoe31hP3chqhjFeD/CoUp3+LVqGLKSCtbl8QsG4cZys4g1BI0cQltbfhiHFBlOQtnW
         AzWuYeO5aBiQpfrgNcvP4rT08f1T/QJ4w1pm5VXKAOU0tbo1ta9TNxJGtKbS0TbeEDyA
         7KtMMVmF5SkpNgGJ/9bGBhwLPgYqYFnfUaGut2cf2mucz5CT5FNHVUB+ZOWka0gkM2M6
         hBJw==
X-Forwarded-Encrypted: i=1; AJvYcCXBGQsyb3C6pvtX7aCZpyzZwQOh9SLiDWMPTL7z7j/OcNZyynWjZZSBgD8Qsh3jTsQzxjE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoC9HFGyMQiCgSYiTi/smYNUG0Yra3TSCAJGM9xOQfk4GZIaGp
	Bs7FtxFhS68CjsnyXAvAyUDa3/dtrrqTOwYLi2YudIY+0TB0Qdvt6FcZ
X-Gm-Gg: ATEYQzzH9hBd44xeh7uyKKnlyewss/cLhbomedHtVLllTOE+Oz2p0WZ36tjAozrHtMS
	334+hAO26R564uirIXpQjnY9z9H8hiN5zRThlNrm+9u5mo9ryMrfCdxvTo2h2F7VyOEBuCjDeea
	3NHOnX23X20N9OqK2rKx31dCCGaVQjjrjDOLO+FZ1jvEIMR/rdzQkyHZpHc29agncONgu+gWGCM
	c8kAuT3VOCh8BsGg0sFKtt1aUGCEIPok0/vOyydzwZPeU8xHvcmFp+GFbm0Lm9/4lspDv5tJ+OI
	tbpvJgiq/R/xzPsuNmuZcWpqxS6n0LFYZZZFaoMEVFrrsuU2M5+kwmLlf/7RS14g1ztT1UJf9qu
	CSbXn+FnZxwiQuUSHWJ8gCqNNyxMHxR7iOvzvHiqAINgtKL4stDhDCDOODWgnhj/c/IfcYLkqBl
	v7thJOUqRQ2iwVCwrvNXinZIgbaIfoxKyjYcY=
X-Received: by 2002:a05:7300:dc90:b0:2c5:a6ce:e534 with SMTP id 5a478bee46e88-2c5a6cef339mr2202718eec.8.1774871115888;
        Mon, 30 Mar 2026 04:45:15 -0700 (PDT)
Received: from localhost.localdomain ([74.48.213.230])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c3c41c1513sm7056897eec.8.2026.03.30.04.45.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 04:45:15 -0700 (PDT)
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
Subject: Re: [PATCH 03/15] sched/isolation: Separate housekeeping types in enum hk_type
Date: Mon, 30 Mar 2026 19:44:48 +0800
Message-ID: <20260330114448.103086-1-realwujing@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260325135904.GB3738786@noisy.programming.kicks-ass.net>
References: <20260325135904.GB3738786@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, Mar 25, 2026 at 02:59:04PM +0100, Peter Zijlstra wrote:
> What the hell for?

Direct and to the point. The original intent was to allow for asymmetric 
isolation (e.g. offloading RCU callbacks while keeping specific timers 
local for very specialized real-time monitoring).

However, I agree that for 99% of use cases, this is unnecessary 
complexity. In V13, I will consolidate these independent enum types 
into a unified housekeeping mask to simplify the configuration and 
reduce the "insane configuration space" you mentioned earlier.
