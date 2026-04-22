Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47BEF249EB
	for <rcu@vger.kernel.org>; Wed, 22 Apr 2026 22:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776897691; cv=none; b=vGZE2gwM+7z7D/jh5XAuENHKK0eDS8vKzL/HNjSpVUSS/nlYI6qMXi0ME1/SLXZiKdGhKEbw53M1pjA/Yz9j6WCFHU1tj+WJGWF/SqfS/abi1308HI3wm7katO8V9243YgJckXTELUtqet1MI014QcthdXf0gEPePPkDChQKzMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776897691; c=relaxed/simple;
	bh=gUEK152lwoAI8GlkDU0asgwfk5vJmlbdfCMd5yE1mWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FRU4fagA5z9ZVzk4H2idyXiZDfNu/pet7OCzjYntdA8z2CjlywKtJfslPEyDhZK5Y6Hr88Od0ZTWNckuRoiQJ+w7oobU0t06W7E/ovXfNDB1SLcxXKpAZolc/QGoHg48KE9ctAe9X0ph2L/2k+FgB6KFSYkFDURf+XnnkbHetG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jVsFPXe0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jVsFPXe0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8D1EC19425;
	Wed, 22 Apr 2026 22:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776897690;
	bh=gUEK152lwoAI8GlkDU0asgwfk5vJmlbdfCMd5yE1mWI=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=jVsFPXe0khsDOZDfOQ+bRAR84cRTacJtOLZZQutTo2qDX+EN0fm28b7fxoVRqxBj4
	 pQxBC8IycM8qZcApMlBirU+WSma8HFjtRP3g7fAeGHr8a8uSirwpxrRRy+7zHgqH0x
	 Qx+du/HEepHE4dQH/OyJ4MUBW5Sk7u9oSyI+GZQfYZv/Ah8Io76ofNDMHynqNIDVpR
	 DsDbf5DjF14ejzWupQM+vSQAVmgZs/gcSA0oQ0KTVqkHoC3yPMSw1o2s9uME/3FhZC
	 tatpnlqShTcBapfl+ujtXTQqZtTyDTSaRVDy6WWnmyMfIq2b5evJL2CX3AUTxdENjc
	 enKVgqr8rO7Fw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 6987BCE129B; Wed, 22 Apr 2026 15:41:30 -0700 (PDT)
Date: Wed, 22 Apr 2026 15:41:30 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: "Harry Yoo (Oracle)" <harry@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hao Li <hao.li@linux.dev>, Alexei Starovoitov <ast@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>, Zqiang <qiang.zhang@linux.dev>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>, rcu@vger.kernel.org,
	linux-mm@kvack.org, Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [RFC PATCH v2 0/8] kvfree_rcu() improvements
Message-ID: <db93f3ad-0446-41ea-b460-40b7fe24a4cb@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260416091022.36823-1-harry@kernel.org>
 <214ca3ac-45b7-4131-86e5-ac134ab0bcbd@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <214ca3ac-45b7-4131-86e5-ac134ab0bcbd@kernel.org>

On Wed, Apr 22, 2026 at 04:30:07PM +0200, Vlastimil Babka (SUSE) wrote:
> On 4/16/26 11:10, Harry Yoo (Oracle) wrote:
> > # Part 1. Allow an 8-byte field to be used as an alternative to
> >   struct rcu_head for 2-argument kvfree_rcu()
> >   (patches 1-2)
> > 
> > Technically, objects that are freed with k[v]free_rcu() need
> > only one pointer to link objects, because we already know that
> > the callback function is always kvfree(). For this purpose,
> > struct rcu_head is unnecessarily large (16 bytes on 64-bit).
> > 
> > Allow a smaller, 8-byte field (of struct rcu_ptr type) to be used
> > with k[v]free_rcu(). Let's save one pointer per slab object.
> > 
> > I have to admit that my naming skill isn't great; hopefully
> > we'll come up with a better name than `struct rcu_ptr`.
> 
> "rcu_ptr" sounds too generic to me. Things like rcu_dereference() talk about
> "RCU-protected pointer" and it could be misleading that "rcu_ptr" has
> something to do with this. Only if Paul think it's ok :)
> But maybe just "kvfree_rcu_head"? As IMHO It's an rcu_head specialized for
> kvfree.

What is in a name?  ;-)

I do have a slight preference for kvfree_rcu_head.

							Thanx, Paul
