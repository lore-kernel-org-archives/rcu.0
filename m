Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26BEB47CA71;
	Fri, 11 Sep 2026 12:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789131438; cv=none; b=C0SPqGYkyDhhKhPi08cf0ky1aR+I/kVtHk2vpToZVsQ4fbQ1TjT4gVsvztKOt4SDd3x0h0kDVvpbbAJOm/gNcudlZWjhFOd5O/MyfH+tSWbkGgK5p0KsvGXNTCgbGqy3/NCfrzBhIpGYUf+ll70rvK206SJn4+ZSdplfB1G9dgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789131438; c=relaxed/simple;
	bh=ei6/coqPeA2IIb+Ksb3fVuzObHky3fFGrbKzBLL/oLc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sb1ka3N5e0VRA4zg68qRLy4GZmq5DCudt+Gb8e6/RATLEl9xcb71BQymXgDyN2vZ5EccOiroSmbidfqo3ZYTzR534noRQfDUq/jp4f4zaL9ygtCcOLC2tNWKmVqCcOa3OCdt61teMp126Uv+a81Y4M5WWf98RaO7Uo5EXxJaYCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=gh7JU/bu; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="gh7JU/bu"
Received: from omf11.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id C64AF1C1801;
	Fri, 11 Sep 2026 12:56:53 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf11.hostedemail.com (Postfix) with ESMTPA id C51C42002A;
	Fri, 11 Sep 2026 12:56:33 +0000 (UTC)
Date: Fri, 11 Sep 2026 08:57:54 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Ye Liu <ye.liu@linux.dev>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Ye Liu <liuye@kylinos.cn>, Michal
 Hocko <mhocko@suse.com>, SJ Park <sj@kernel.org>, Lorenzo Stoakes
 <ljs@kernel.org>, Oleg Nesterov <oleg@redhat.com>, peterz@infradead.org,
 paulmck@kernel.org, mingo@redhat.com, mic@digikod.net, tglx@kernel.org,
 akpm@linux-foundation.org, david@kernel.org, linmiaohe@huawei.com,
 nao.horiguchi@gmail.com, rafael@kernel.org, gnoack3000@gmail.com,
 gourry@gourry.net, rientjes@google.com, shakeel.butt@linux.dev,
 xu.xin16@zte.com.cn, chengming.zhou@linux.dev, will@kernel.org,
 boqun@kernel.org, frederic@kernel.org, neeraj.upadhyay@kernel.org,
 joelagnelf@nvidia.com, josh@joshtriplett.org, urezki@gmail.com,
 juri.lelli@redhat.com, vincent.guittot@linaro.org, tony.luck@intel.com,
 reinette.chatre@intel.com, x86@kernel.org, paul@paul-moore.com,
 jmorris@namei.org, serge@hallyn.com, pavel@kernel.org,
 lance.yang@linux.dev, mhiramat@kernel.org, pmladek@suse.com,
 longman@redhat.com, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
 qiang.zhang@linux.dev, dietmar.eggemann@arm.com, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com, kprateek.nayak@amd.com,
 mark.rutland@arm.com, Dave.Martin@arm.com, james.morse@arm.com,
 babu.moger@amd.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, rcu@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-security-module@vger.kernel.org
Subject: Re: [PATCH v3 12/15] unwind: convert process/thread iterator to
 for_each_process_thread_rculock
Message-ID: <20260911085728.47d3b351@gandalf.local.home>
In-Reply-To: <20260911075800.491472-13-ye.liu@linux.dev>
References: <20260911075800.491472-1-ye.liu@linux.dev>
	<20260911075800.491472-13-ye.liu@linux.dev>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: C51C42002A
X-Stat-Signature: etnbh8canf3f1kmc7jj9utoztbtwrixp
X-Rspamd-Server: rspamout07
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/KtCaZ9/tsi0hxBkYuIS2CFwjudzULElM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=E0ssg816zZqGUemHya07FEZhfM/BCVla+Qd4d9ec2gc=; b=gh7JU/bubZhrpxGBgrxho2alJtCMELUzto5Po0cae150cpl0BavJgC2dRHwU4FvXJDWgj7yOyyuU2Stz8X9XeWiOLT41yNeO3tUvFSw40L8rqSvkkd6r1CgWOdrbH+uscOfxXomLGGWuLAhDqRhufkG1WPXyO7BUnbgmm77KIMY=
X-HE-Tag: 1789131393-869492
X-HE-Meta: U2FsdGVkX18a8IZpiamWSNHMOGJqi766L2hoU7BxJ2jc1mbGcETaj4OLytypvLF1C/8k4P6eKXvas+lrJd2fkaPBqv3KUx75daqT4beXqnn0s2TYyKccRHJ75eB75GbvBLtsIiHrPJIERzvArIitexLxj/cO9kvTrTnKbk61hiBe7r2nGDYiIOb1LXm9ZUaQdU3q4M27XcVbYDqNe8LJroq3pRtqtAzUxadzwfvnx2yAElBekjB5HsCjqmT+iIl7VHmhuoQbgdgPLcfu1uuZPVtwqwe4tPyVIqWTA8JTY+/xeG00csaaYSlhKyUuwM4zCh0hTIx4hiAhC0O7Hxmc1L4GgNlGmvWrkiJxOxCWnZSjVtEWmHLD9bmVh59kOkTIR4M5NtVHKoy0W8PLA7ap0pa5fEVrBPjp3LVjOdSzjgHtfss8M5cvpx2hDQTJ21CwWfHIl/mD6Xc5kDP/SGon2U9aC1WoX7LRXWG0diJrZik=

On Fri, 11 Sep 2026 15:57:57 +0800
Ye Liu <ye.liu@linux.dev> wrote:

> From: Ye Liu <liuye@kylinos.cn>
> 
> Replace guard(rcu)() combined with for_each_process_thread() loop in
> kernel/unwind/deferred.c with for_each_process_thread_rculock(),
> which scopes the RCU read lock to the loop body via scoped_guard(rcu).
> 
> No functional change.
> 
> Signed-off-by: Ye Liu <liuye@kylinos.cn>
> Acked-by: Michal Hocko <mhocko@suse.com>
> Reviewed-by: SJ Park <sj@kernel.org>
> Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> Reviewed-by: Oleg Nesterov <oleg@redhat.com>

Acked-by: Steven Rostedt <rostedt@goodmis.org>

-- Steve
