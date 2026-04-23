Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1FA7D531
	for <rcu@vger.kernel.org>; Thu, 23 Apr 2026 01:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776906529; cv=none; b=cItASycEKihsDLFYVgA08LTcJ70wp5zx1YOvR5xep9TyfES0NZw8qxE9pAh6hCEokxBhGN5I8kFTqIC92H3EYBPlwTpIXejQ5z7WYkYgI8qewcY/Pyz7tboQDyxU+M4QK3gj8o89eyK9kHcgHYH1fUbI4xpSsEL65rGQENhpD2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776906529; c=relaxed/simple;
	bh=eM7I+z11rvz3UT8atgEe1MBPkEiQna5s0ErFx4g2s9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=chYTFMl4tXcUgzqmqBt/X/drg/u84dZ1GCHbWuF86CV1uUpHv6ZZFEizes4mh5mZ2XHoEHkzRezbmSFyL3r/+h4z31i84YfkVFP8zgflGouISgZtyiGwVhZvAAJzEwdliL8PJ3uM8uTeNwZA0GZMCXeDbuv/578tsaUmb20JEj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D9UVNgCJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D9UVNgCJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F08A5C2BCB2;
	Thu, 23 Apr 2026 01:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776906529;
	bh=eM7I+z11rvz3UT8atgEe1MBPkEiQna5s0ErFx4g2s9M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D9UVNgCJ0cLMPrZuVc38yYovvZZJAYFz6SSYgXByaedaAsv/HkddogoZqdKeWVAZK
	 7TSOt9gbCNoY/DoNtxW2MfJxhwB65t14eX094IaBtK5IMJ8RGo2YDl7GTk537eDuKZ
	 jPU+NZTpTZ72mLsDkiUOMkmzOOb7yLdA2t0sPWbw7KrF8bX8/RgP636UJOFnKwDNM1
	 hSoMYksqqIJNAWbCzM6JzX4IHui8Q7ip1SiZwGfjW92x1tuNOxwwyXoNTaIw2AZmyF
	 LOTq/usjn9dBX+nzYlJv3u3ARJvpA1eBWXsw6NeFFQl2ETBnBA/YlzjKTqpObC0HEe
	 +f9aH9iRyCfxg==
Date: Thu, 23 Apr 2026 10:08:47 +0900
From: "Harry Yoo (Oracle)" <harry@kernel.org>
To: Uladzislau Rezki <urezki@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hao Li <hao.li@linux.dev>, Alexei Starovoitov <ast@kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>, Zqiang <qiang.zhang@linux.dev>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>, rcu@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 4/8] mm/slab: introduce kfree_rcu_nolock()
Message-ID: <aelxH--hZkCahPv6@hyeyoo>
References: <20260416091022.36823-1-harry@kernel.org>
 <20260416091022.36823-5-harry@kernel.org>
 <aejeVK0J_jHSfVhD@milan>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aejeVK0J_jHSfVhD@milan>

On Wed, Apr 22, 2026 at 04:42:28PM +0200, Uladzislau Rezki wrote:
> On Thu, Apr 16, 2026 at 06:10:18PM +0900, Harry Yoo (Oracle) wrote:
> As discussed or noted earlier, having third argument and check the
> entire path with "if (allow_spin)" is not optimal and is not good
> approach. I do not think it this would be a good fit for mainline.

I understand that this pattern is pretty uncommon and adds complexity.
But there is a reason why we're doing this. As Alexei pointed out
earlier, even rare spikes of irq_work hurt performance [1]; that can be
avoided in most cases where the lock is not in use. That's why buddy [2]
and slab [3] accepted this pattern despite the added complexity?

[1] https://lore.kernel.org/linux-mm/CAADnVQKk_Bgi0bc-td_3pVpHYXR3CpC3R8rg-NHwdLEDiQSeNg@mail.gmail.com
[2] https://lore.kernel.org/linux-mm/20250222024427.30294-1-alexei.starovoitov@gmail.com 
[3] https://lore.kernel.org/linux-mm/20250909010007.1660-1-alexei.starovoitov@gmail.com

> I think a better option is to add a separate kvfree_rcu_nmi() helper,
> or similar, and avoid complicating the generic implementation. Otherwise,
> the common path risks becoming harder to maintain.

It's unfortunate that I didn't provide performance data to justify
adding complexity. I can try, but apparently you're not talking
about that.

Rather, you seem to be arguing that you're against this pattern
no matter what the benefits are?

I'm confused.

-- 
Cheers,
Harry / Hyeonggon
