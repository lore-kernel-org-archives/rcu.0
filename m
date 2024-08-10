Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B71A22083;
	Sat, 10 Aug 2024 20:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723321837; cv=none; b=g72W+gr9SfmnitVP6FsOW/MExuDCAWvb+XIctMUiyFZzdjdlSzzUF2VNeC3W55nbM+Fvjn2PfuhcqemRo9fFBiyu4Tt14plfDJl1doImIipL4y4UEaOGy0SwAFV/TqBd0goLoS29PLy1gvhHBYM2bCRJYL24dhPBlmmt3swZ7W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723321837; c=relaxed/simple;
	bh=kSnRQocWSq3naynHnxtVJuyGiXsM9l+OaEt9HNds17s=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=SDXzf1Np9QrcPo94l0vCPYuB23tJ5dWSZEA+a/m3f8cLz+EJ/DjuUcbRDJP7JWzAkGcswab24WWe23xq1t9uds05/kJdDoZbnysAEEl13Dy2lCc3LzjmmnA+xq+/pyKzmbfVHLpd9REx6y6e+hy1trLHqh19MxAilT4/C3vEvvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=i74G9X5s; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="i74G9X5s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A254BC32781;
	Sat, 10 Aug 2024 20:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1723321836;
	bh=kSnRQocWSq3naynHnxtVJuyGiXsM9l+OaEt9HNds17s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=i74G9X5sIfkUC+QCxMkvK9Af7K+3Mdmy8TqNWIJQ36dipYpugi9rA2NxDDEbwSYZT
	 esGw5TmmRlSXBkT9v1wRapKtLsCsj2q+UDWDIZvI83LlRyjAqNGC4cFwW6LE0/eO5P
	 9Q0Jhill/gi61D/JaXjGnKzruOrtapitA/vQ2Ar0=
Date: Sat, 10 Aug 2024 13:30:34 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Jann Horn <jannh@google.com>,
 "Paul E. McKenney" <paulmck@kernel.org>, Joel Fernandes
 <joel@joelfernandes.org>, Josh Triplett <josh@joshtriplett.org>, Boqun Feng
 <boqun.feng@gmail.com>, Christoph Lameter <cl@linux.com>, David Rientjes
 <rientjes@google.com>, Steven Rostedt <rostedt@goodmis.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan
 <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>, Julia Lawall
 <Julia.Lawall@inria.fr>, Jakub Kicinski <kuba@kernel.org>,
 "Jason A. Donenfeld" <Jason@zx2c4.com>, "Uladzislau Rezki (Sony)"
 <urezki@gmail.com>, Roman Gushchin <roman.gushchin@linux.dev>, Hyeonggon
 Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, rcu@vger.kernel.org, Alexander Potapenko
 <glider@google.com>, Marco Elver <elver@google.com>, Dmitry Vyukov
 <dvyukov@google.com>, kasan-dev@googlegroups.com, Mateusz Guzik
 <mjguzik@gmail.com>
Subject: Re: [-next conflict imminent] Re: [PATCH v2 0/7] mm, slub: handle
 pending kfree_rcu() in kmem_cache_destroy()
Message-Id: <20240810133034.433d3e1338d3bd8a0c90bf45@linux-foundation.org>
In-Reply-To: <167495c0-187b-4fb8-8de5-63db0aef193e@suse.cz>
References: <20240807-b4-slab-kfree_rcu-destroy-v2-0-ea79102f428c@suse.cz>
	<54d62d5a-16e3-4ea9-83c6-8801ee99855e@suse.cz>
	<CAG48ez3Y7NbEGV0JzGvWjQtBwjrO3BNTEZZLNc3_T09zvp8T-g@mail.gmail.com>
	<e7f58926-80a7-4dcc-9a6a-21c42d664d4a@suse.cz>
	<20240809171115.9e5faf65d43143efb57a7c96@linux-foundation.org>
	<167495c0-187b-4fb8-8de5-63db0aef193e@suse.cz>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 10 Aug 2024 22:25:05 +0200 Vlastimil Babka <vbabka@suse.cz> wrote:

> >> I guess it would be easiest to send a -fix to Andrew as it's rather minor
> >> change. Thanks!
> > 
> > That's quite a large conflict.  How about we carry Jann's patchset in
> > the slab tree?
> 
> OK I've done that and pushed to slab/for-next. Had no issues applying
> the kasan parts and merge with mm-unstable (locally rebased with Jann's
> commits dropped) had no conflicts either so it should work fine. Thanks!

Cool.  I have dropped the copy of v8 from mm.git.
