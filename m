Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6DB32741B6
	for <rcu@vger.kernel.org>; Wed, 22 Apr 2026 01:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776820602; cv=none; b=WyAOe+EeI5Pt5XR0RQjFKB1D7nd0GGWceMXoxLCdrkdYSzuUiM8rQJ+JB89OmvwuBubN8+PDxZWw5HJiYW2Lo0laVwLopDdaTeZozvwUGI0CD5nN1m5lV4M1wUCYfXro/ojWqGGdWhHpvowdIbTZiTJG14mohT9yzfJjx3Szxfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776820602; c=relaxed/simple;
	bh=iCRI6Vw9mtwmyRKI+DMnjzpiQb/k2Wa71IR5f/lqDhY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HVr+7im80PGFkPGkENnbQ6gnXxYjBs6EqjfcvMFzr7vU0Mkpk3nFnu0DB8noD7R/L9ktQG/6kQFq1wiITVLpobnQ89se8oEt3faNb8RfHLUeVQTCqpUeahxqEb6CsVm9HW9fzLoKx1bf/r/UpGV7F1S77jaTUUpEs37dEDxOi4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=If8Mq5F7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="If8Mq5F7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 245A7C2BCB0;
	Wed, 22 Apr 2026 01:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776820602;
	bh=iCRI6Vw9mtwmyRKI+DMnjzpiQb/k2Wa71IR5f/lqDhY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=If8Mq5F7eh58pV1iYu+Mb/FJJ7WLmRsqjfIBYcpy4kDo90dfrb+5a8Ovglcz6Btn7
	 yar9YYJucxBLeDZG3SC4fSkrA0tIQZJkYhvPYeUk+zgavB1jpqC973fdZGLil5bFpe
	 09zP56rDorwiGekgO2T10ObEoR9CsIsCkpAVBYneV3slDnbGjnKDq9bqkgxlUZJf+M
	 E8TJxmXcT6xlPtOaLzOdpsFym+5nm2n9waY74DVmIpLzu1o1oZt4CqSQqDOFO9M6te
	 H6KLDoWMJjiPNOmltQ3hJzI3dsbZt7iPZkm+hnWgsTXTBnj4DK09VdO6mHevaIifYk
	 EyCJ/TL441yhA==
Date: Wed, 22 Apr 2026 10:16:40 +0900
From: "Harry Yoo (Oracle)" <harry@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hao Li <hao.li@linux.dev>, Alexei Starovoitov <ast@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>, Zqiang <qiang.zhang@linux.dev>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>, rcu@vger.kernel.org,
	linux-mm@kvack.org, Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 2/8] fs/dcache: use rcu_ptr instead of rcu_head for
 external names
Message-ID: <aeghePMTwTof8uzj@hyeyoo>
References: <20260416091022.36823-1-harry@kernel.org>
 <20260416091022.36823-3-harry@kernel.org>
 <20260421202151.GF3518998@ZenIV>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260421202151.GF3518998@ZenIV>

On Tue, Apr 21, 2026 at 09:21:51PM +0100, Al Viro wrote:
> On Thu, Apr 16, 2026 at 06:10:16PM +0900, Harry Yoo (Oracle) wrote:
> > When a file name length exceeds 31 (DCACHE_INLINE_LEN-1),
					^ Now I see a typo here

> #ifdef CONFIG_64BIT
> # define DNAME_INLINE_WORDS 5 /* 192 bytes */
> #else
> # ifdef CONFIG_SMP
> #  define DNAME_INLINE_WORDS 9 /* 128 bytes */
> # else
> #  define DNAME_INLINE_WORDS 11 /* 128 bytes */
> # endif
> #endif
> 
> Where do you get that 31 from?

Oh god, I blindly got it from the wrong file:

$ csdef DNAME_INLINE_LEN # my custom alias for cscope
tools/testing/selftests/bpf/progs/find_vma.c DNAME_INLINE_LEN 14 #define DNAME_INLINE_LEN 32
include/linux/dcache.h DNAME_INLINE_LEN 82 #define DNAME_INLINE_LEN (DNAME_INLINE_WORDS*sizeof(unsigned long ))

Thanks for pointing it out.

Should have been 39.
Will fix.

-- 
Cheers,
Harry / Hyeonggon
