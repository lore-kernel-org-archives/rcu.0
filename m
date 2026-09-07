Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B21375F82;
	Mon,  7 Sep 2026 21:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788817480; cv=none; b=SbInF+m8D4+UcTlFnIs40kgRsv+Bx5EqChUKj0RK75Jm4pUgOPyQQQmBSD9UVMC6lulViJ8VZgn5iNKkz2iQhaG1PdgHcvO30sIoZtCK48yuwR3LReVCtuuxuf3z97FHOXOmwF0EFstKPxb0CzID4mHpnUEM2ThSRsez1iDH6sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788817480; c=relaxed/simple;
	bh=2emHG63gggtJxU9tI+NWaLUyY6dcX1LgemvO7ss7lmM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dJvECBAzkEVq6aMjfCPdwt7CtEgh+GFyqzhZza/mimHs36o1PdBIy+ZWNvHejq1Tt1bvDd9LixhsRt/yCuZ2OwEM+1tZkV/dbyPhDJZfd6kzqnUJ4Z05mE+xAspaHAmsM2AyfZz0J9DAmqfMIwe/3+kw58oyGj4leO00l548zEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ERrMVVR0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ERrMVVR0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC6CF1F00A3A;
	Mon,  7 Sep 2026 21:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788817479;
	bh=e8PEL7ctvrs8f9gJpA/MPoY+Iz+nKZl0JJs1AfAL5Us=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ERrMVVR0YoM06xDxrpDyejQIadx+eQ9bZoWCmhpJgu/z2Ag8xwoBwAR0W6lsWUUn1
	 10TgoAgTfR4oiRlgC0NQnYV3LwG4qDS0Z8J3Lye1zTT+F8y2lgfcCviKGokMfi3IhS
	 fdoMi5jNaNCng9cYb78yE8LXv3wErzf3oU3vDvK7enqj8LpGMMntCt0i6Bzyjblokx
	 BD6JCNmeWcS5tP96pScNCGcTK4eEGwIJTYCiapCvTbuXaO29J9Q1Nc7qv4EmeGQfRA
	 shDUPHyzErFUUDtFpQA+jm6godpoOjzdEJZRR94hbjJHxygzPwT6uknFv50qfBuUz4
	 yIdkUtPJT+n7g==
From: SJ Park <sj@kernel.org>
To: Ye Liu <ye.liu@linux.dev>
Cc: SJ Park <sj@kernel.org>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Justin Suess <utilityemal77@gmail.com>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
	mhocko@suse.com,
	peterz@infradead.org,
	paulmck@kernel.org,
	mingo@redhat.com,
	rostedt@goodmis.org,
	jpoimboe@kernel.org,
	oleg@redhat.com,
	tglx@kernel.org,
	akpm@linux-foundation.org,
	david@kernel.org,
	linmiaohe@huawei.com,
	nao.horiguchi@gmail.com,
	rafael@kernel.org,
	ljs@kernel.org,
	rientjes@google.com,
	shakeel.butt@linux.dev,
	xu.xin16@zte.com.cn,
	chengming.zhou@linux.dev,
	will@kernel.org,
	boqun@kernel.org,
	frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	joelagnelf@nvidia.com,
	josh@joshtriplett.org,
	urezki@gmail.com,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	tony.luck@intel.com,
	reinette.chatre@intel.com,
	x86@kernel.org,
	pavel@kernel.org,
	lance.yang@linux.dev,
	mhiramat@kernel.org,
	pmladek@suse.com,
	longman@redhat.com,
	mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com,
	qiang.zhang@linux.dev,
	dietmar.eggemann@arm.com,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	kprateek.nayak@amd.com,
	mark.rutland@arm.com,
	Dave.Martin@arm.com,
	james.morse@arm.com,
	babu.moger@amd.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	rcu@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 8/8] security/landlock: convert thread iterator to for_each_thread_rculock
Date: Mon,  7 Sep 2026 14:44:28 -0700
Message-ID: <20260907214430.88978-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260907081334.1152889-9-ye.liu@linux.dev>
References: 
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon,  7 Sep 2026 16:13:34 +0800 Ye Liu <ye.liu@linux.dev> wrote:

> From: Ye Liu <liuye@kylinos.cn>
> 
> Replace guard(rcu)() + for_each_thread() with for_each_thread_rculock(),
> which scopes the RCU read lock to the loop body via scoped_guard(rcu).
> 
> No functional change.
> 
> Signed-off-by: Ye Liu <liuye@kylinos.cn>
> Reviewed-by: Justin Suess <utilityemal77@gmail.com>
> Reviewed-by: Günther Noack <gnoack3000@gmail.com>

Reviewed-by: SJ Park <sj@kernel.org>


Thanks,
SJ

[...]
