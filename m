Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351672DCF58;
	Tue, 23 Dec 2025 17:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766510903; cv=none; b=e9dJjTIq3CO3e/J3KX/gjy0jo18/JLbXexTd3Xz3pQKZwR6zqRiP0gCcNu4YrYgN7yEhKW45+tLpAsW9G6lbLDIyOdiKXi16qXrBg8yveD7RLUes2u9cvG6F6ntcUCSTsscJMeOIu29POHTw0xF/yDXhrv1QhHnQ9cHms5HaCdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766510903; c=relaxed/simple;
	bh=xQDu/jZHI78AoY/aXHi+1HZkWvPQZ3AQ7cxlelO6/Yk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ezZOfzLJDTduIKw/j5V7jwgUhdqLuhsN5RXa4H6Ycm89L8Tb99GVkcylMJ+s9crBcYJnSacXmRUeuh3XqfdSSFhsNGEEHrPsGPCzwYFdDTF4ZKtDpUEMXTZ7Kwu/L62m548G6lcMQj6y+K2BfEO1a+L4VU67d0SiKzVqLvGl7yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sjd8+WKh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sjd8+WKh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 856E6C113D0;
	Tue, 23 Dec 2025 17:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766510902;
	bh=xQDu/jZHI78AoY/aXHi+1HZkWvPQZ3AQ7cxlelO6/Yk=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=sjd8+WKhjRlahFJ6MuawUZvZ2JeaWmeXcTImX5PnAHAjk7+fdoKEHsSZzaYuMAffk
	 Uu5FRUcq/5fL6hkdm8zgBxZIA+RXJTbfZOlKHETVJ6fdtUDPgxy/6pBtc11cxpqXNM
	 0Xqeoi4HNl0y3YRz+X8m8DcPi468P63x88WTUj/AlN0H6o0vOwVRCqElajd09B61Mg
	 uTjfwckAJlRYaynADyTfucGlvyt2xB75KHhLlB1R6VoWurehxt2N5edKfALhHAHUY8
	 cSYGj5eH2clNjMwVJQ13kRSJrE/Y4Tp7ozmzxPJAL4P61gdhDD95VFnnegKfuP+GRf
	 OLo+Xi4DBpfwQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 2B8B8CE1A0B; Tue, 23 Dec 2025 09:28:22 -0800 (PST)
Date: Tue, 23 Dec 2025 09:28:22 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	Davidlohr Bueso <dave@stgolabs.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>, rcu@vger.kernel.org, clm@meta.com
Subject: Re: [PATCH] rcutorture: Fix operator precedence bug in exp_current()
 invocation
Message-ID: <52bda0a7-5311-4e62-89c5-287c731548e4@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20251223004407.61147-1-joelagnelf@nvidia.com>
 <4bbae00e-f078-4f1e-a1e0-b1cdc72981de@paulmck-laptop>
 <20251223113758.2c6bb15d@gandalf.local.home>
 <f99bbb2e-62bd-47fb-8cee-07716766c087@nvidia.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f99bbb2e-62bd-47fb-8cee-07716766c087@nvidia.com>

On Tue, Dec 23, 2025 at 12:22:51PM -0500, Joel Fernandes wrote:
> On 12/23/2025 11:37 AM, Steven Rostedt wrote:
> > On Mon, 22 Dec 2025 17:12:18 -0800
> > "Paul E. McKenney" <paulmck@kernel.org> wrote:
> > 
> >> Good eyes, thank you!
> >>
> >> Unfortunately, Chris Mason beat you to it:
> > 
> > Was it Chris or his AI? ;-)
> 
> Does it matter? It is like saying, was it "Chris or his text editor". ;-)

Adding Chris on CC for his thoughts on whether it was him or his AI and
whether or not this matters.  Should he choose to share any thoughts on
either topic.  ;-)

							Thanx, Paul
