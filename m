Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0763AFAEF;
	Fri, 26 Jun 2026 19:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782501907; cv=none; b=LeovoQ41pxvUOpbkajfnnVzaAZi7JF4/WDSNMWZ2rWtx4EAzBu0C4N1y5g/KMsUOZ82OqLwHETHaEIQz1cmCbKYhEdbVjH9+kAWTz/JQzZ2+yeVc1QFFl9RA/XTcikxKPS1D1MBoiTKURi2ViqZTmFEr/Ef1zXVp0wCPxdEAmUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782501907; c=relaxed/simple;
	bh=/d50merst5oqDqo0Y2DJ1pc+8hFIGkcX2PuKQEYouR8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OOzJ6WdmXITa+u+PhgK4gbgmv0SKwKgvgZf84uWHjnZVOIm71+rzNXnAbPGRPKl44FSImpcpBMvjV+w2jxA/MXpb3G63d+e6gWXL+glzUoKaV044F7LGCHm+zcSUXMbZbhpbTq6a6eZ5IhQM4510UxtlYq7qK4+aGQsjW+ARpWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kG7tMiR2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kG7tMiR2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EC931F000E9;
	Fri, 26 Jun 2026 19:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782501906;
	bh=kzlc6x7h5MGKZw0ju9UBh1QbH6rWURT+VBtLC6Is2v4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=kG7tMiR21Cwr4Pfu4W6HHYu9p3dH0vBWo5tAqGeEKJVl1N97r1XQ0XoE5YG0QIomd
	 4wqHXMYR4dIheAfUYGdH+1jEGxZ5Wci3JTrFrdIESpomW7W/3UA7LlV8zDgzhZblBK
	 gYdAc0cCruB4v2CqJ2w53PQhjQig4KuoT4ZnDvIvrUFyYJXgiZgNOqQWU4eZmd/kiN
	 Z0gyPnUcZapCFa+qC5imW8+UrkZ352Y58HGrVAW0dJxMGIhhvcfWYIJbVQ8qHQQx7s
	 nG8thIFH9EYfDW3xB0MQUgPbkefFxo2pftdO38W9Tl2XtvlYh010INCfkFpc7lD0r0
	 OZ7pijjyZU3fw==
From: Thomas Gleixner <tglx@kernel.org>
To: Usama Arif <usama.arif@linux.dev>, lkmm@lists.linux.dev,
 joelagnelf@nvidia.com, linux-kernel@vger.kernel.org,
 marco.crivellari@suse.com, paulmck@kernel.org, rafael.j.wysocki@intel.com,
 rdunlap@infradead.org, riel@surriel.com, sshegde@linux.ibm.com,
 ulfh@kernel.org, usama.arif@linux.dev, yury.norov@gmail.com,
 rcu@vger.kernel.org
Cc: shakeel.butt@linux.dev, hannes@cmpxchg.org, kernel-team@meta.com
Subject: Re: [PATCH v2] smp: Use release stores for csd_lock_record() state
In-Reply-To: <20260622163807.4187558-1-usama.arif@linux.dev>
References: <20260622163807.4187558-1-usama.arif@linux.dev>
Date: Fri, 26 Jun 2026 21:25:03 +0200
Message-ID: <874iiphzow.ffs@fw13>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Jun 22 2026 at 09:38, Usama Arif wrote:
> __csd_lock_record() publishes per-CPU CSD debug state that is read by
> csd_lock_wait_toolong() on another CPU.  The remote side first reads
> cur_csd with smp_load_acquire() and, when non-NULL, may then read the
> matching cur_csd_func and cur_csd_info fields.

That's not how a change log should look like. See

      https://docs.kernel.org/process/maintainer-tip.html#changelog

When I use that template of context, problem, solution, then I clearly
have to assume that the above paragraph describes the current state,
which is not the case.

So in the first paragraph you want to explain that the code uses
smp_mb() to protect against foo.

The second paragraph explains the problem, i.e. that smp_mb() is a big
hammer.

The third paragraph explains how this can be replaced and why the
replacement is correct.

