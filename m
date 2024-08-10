Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB439EC2;
	Sat, 10 Aug 2024 00:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723248677; cv=none; b=XK7AkwEp/UqTP1D1OXzt6qH5wGYUA0Nnqko8XVW4bgF1YvFcHLwKs6+PCsj+o/Mw9H1/qGt+0IZLYBBM3LZi2ABhZaApN0otiXSWtWjY7cTu1KBzTV7vVm/egi+vT27rhxi5MjMq7JIL+bJzn2rjH88xgVD+8HdfIgDQ8jq/ot8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723248677; c=relaxed/simple;
	bh=gYS5jG6xlZXpyS9QHhFNcXJ6ASrsMVVrI/e/j0Qdmdo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=NxdVF2msmSkTK1XFOtFdHKcAHglxEivWz+KevnWDisTT9NpamE4vfV6k8dBVRTkvzvgxQznMIRixlLB2OmmxpcnfKLybIBPmLv7N003/B3tXXn+ZLq+Glg2gHalp80O8iTVzhV+xJejD/LLJ6UWM5jwdz5R+eB1Umj36s0XYdmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=XxoyP0t1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="XxoyP0t1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF830C32782;
	Sat, 10 Aug 2024 00:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1723248676;
	bh=gYS5jG6xlZXpyS9QHhFNcXJ6ASrsMVVrI/e/j0Qdmdo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XxoyP0t1FdEWz+90LiVzsWSUn38ZfzifjeCgencTdiv+8miMXnJyreCrVt7DsIHjd
	 0+0JPSr3sxikYEZVMHnH+gutK77KfSWOUZnrL3Weewi2bO+QxJqVphKsAehfholDZF
	 1a1pYqOVJdpAoLVJ2dvao0zqZqz99345ByME7AqU=
Date: Fri, 9 Aug 2024 17:11:15 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Jann Horn <jannh@google.com>, "Paul E. McKenney" <paulmck@kernel.org>,
 Joel Fernandes <joel@joelfernandes.org>, Josh Triplett
 <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>, Christoph
 Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>, Stephen
 Rothwell <sfr@canb.auug.org.au>, Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan
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
Message-Id: <20240809171115.9e5faf65d43143efb57a7c96@linux-foundation.org>
In-Reply-To: <e7f58926-80a7-4dcc-9a6a-21c42d664d4a@suse.cz>
References: <20240807-b4-slab-kfree_rcu-destroy-v2-0-ea79102f428c@suse.cz>
	<54d62d5a-16e3-4ea9-83c6-8801ee99855e@suse.cz>
	<CAG48ez3Y7NbEGV0JzGvWjQtBwjrO3BNTEZZLNc3_T09zvp8T-g@mail.gmail.com>
	<e7f58926-80a7-4dcc-9a6a-21c42d664d4a@suse.cz>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, 9 Aug 2024 17:14:40 +0200 Vlastimil Babka <vbabka@suse.cz> wrote:

> On 8/9/24 17:12, Jann Horn wrote:
> > On Fri, Aug 9, 2024 at 5:02 PM Vlastimil Babka <vbabka@suse.cz> wrote:
> >> On 8/7/24 12:31, Vlastimil Babka wrote:
> >> > Also in git:
> >> > https://git.kernel.org/vbabka/l/slab-kfree_rcu-destroy-v2r2
> >>
> >> I've added this to slab/for-next, there will be some conflicts and here's my
> >> resulting git show or the merge commit I tried over today's next.
> >>
> >> It might look a bit different with tomorrow's next as mm will have v7 of the
> >> conflicting series from Jann:
> >>
> >> https://lore.kernel.org/all/1ca6275f-a2fc-4bad-81dc-6257d4f8d750@suse.cz/
> >>
> >> (also I did resolve it in the way I suggested to move Jann's block before
> >> taking slab_mutex() but unless that happens in mm-unstable it would probably be more
> >> correct to keep where he did)
> > 
> > Regarding my conflicting patch: Do you want me to send a v8 of that
> > one now to move things around in my patch as you suggested? Or should
> > we do that in the slab tree after the conflict has been resolved in
> > Linus' tree, or something like that?
> > I'm not sure which way of doing this would minimize work for maintainers...
> 
> I guess it would be easiest to send a -fix to Andrew as it's rather minor
> change. Thanks!

That's quite a large conflict.  How about we carry Jann's patchset in
the slab tree?
