Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01FE21CC71
	for <rcu@vger.kernel.org>; Thu, 23 Apr 2026 01:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776907879; cv=none; b=A78bBTlaNMo7DyomKLKXGzUyRsG2ZOsHMo81BpmenhqXjvy808wsyRwVgEoc+aXx+qJMkXJvu0vSAnbM3OnTeQz9EuKt+RS5Nnnj4AiUxN+rMbiSgw0jTxL++PKjumqazjJKTCdKiZqfHjdUP5bnfRBYItnux80srlb+ge0kFMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776907879; c=relaxed/simple;
	bh=jlAGtqvwrlvzYzSmfvFrSnoSFtUA9CDJqYVY/DrcyQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=grZYRv8+OohXIsnBKNWNSMrCdkcpBwxVakHxPh2zjWTnNyrrrpjMNzMaBwR5yFuf2CxHvamKQx5ywe6QL4Eb3pyrgVWeRi4+ta8LmV2iy6+SW9gOcDERby/ZCmwsgqa+uUdRCTKU9b+xj5ZfNtXJkVbSV5G51PXCU4j9m+S8RYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZEJZWo7I; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZEJZWo7I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFFCAC19425;
	Thu, 23 Apr 2026 01:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776907879;
	bh=jlAGtqvwrlvzYzSmfvFrSnoSFtUA9CDJqYVY/DrcyQE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZEJZWo7IQJuIGCKRZDR/ii0H6m9xm9EV9uOtNDrN0f8QCeqLoedks257e0Mte/UCw
	 K5+jGRaevfQ5qE+RMQzQ+nXMSoOHIhQC7rwC4oXhV1gxV4htVQUfw743nLlosIzf9g
	 vYk53ptKBWwJ20msbQngDer/b42Yew2NBQhJezXnlYq4uckN2HOunUPC4eYb3XrTMV
	 5SjtxITuoDs3apa4uPiphxFQvVF7ggKuZMx3jaQmLSbibTgethbcUWXDK9PNxtIhOs
	 V2entigvS7oOgS4YQ/hwA1sJI9gh76lTD8zXpFw7HpVIDrG28elz6SfcTk7WrXLne4
	 p5tFoFwXqPwJA==
Date: Thu, 23 Apr 2026 10:31:17 +0900
From: "Harry Yoo (Oracle)" <harry@kernel.org>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
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
	linux-mm@kvack.org, Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [RFC PATCH v2 0/8] kvfree_rcu() improvements
Message-ID: <ael2ZUl2neBh2VGa@hyeyoo>
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
> "rcu_ptr" sounds too generic to me.

to me too ;)

> Things like rcu_dereference() talk about
> "RCU-protected pointer" and it could be misleading that "rcu_ptr" has
> something to do with this.

Agreed.

> But maybe just "kvfree_rcu_head"? As IMHO It's an rcu_head specialized for
> kvfree.

I like the name better and will rename it, thanks!

-- 
Cheers,
Harry / Hyeonggon
