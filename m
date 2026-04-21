Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6309A28504F
	for <rcu@vger.kernel.org>; Tue, 21 Apr 2026 20:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776802674; cv=none; b=ei5IJlhnPvFTcPlrclqV30/QWj/3dyDSxk0vNRaOswjuYIr3Pb7mU0itw3V+dGL2rrpI3sg1HZpv6y/hVx9YMo8ryW8f14AibA0jgEbEn8GEM8CsDAL916xJMqXQY1/t65X55YssjUl2Kw8q9MHm6Ex3N8BXX7ajyXiQ7CgiLBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776802674; c=relaxed/simple;
	bh=KfnbFnhXl5l+gEKvgs73Yb0h2IqpHCm5Z9HckyuX2x0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zwb6ZUL2MwWGgAA+R4PP/8wwcQvbIvN9lIfHEP2jQ9OHRijmt/5K//wHJU5QKgv4+EaB5dXK9fWJ179L/7KXVVTHsuSQ1SonjmIPPReqEZEPY/GRdibaL9vQDG6Uex9s58XFaYSPV/Qrx605d5JeRc77+ppSHT4JQG693RnoMYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=c3pjcWJQ; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="c3pjcWJQ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Zmk5kCu+N+tLkVd3CGGCvLP7PJjgMTpvngzmVMjrx2c=; b=c3pjcWJQrzP/CnBpWyzEsOODaL
	IpEOkNzpKCQufKIBgcCtLaLUdZUbppx0takTo14jvYiuZqp8xdzYI2/2/zE6ytz6edrnoZVaXBINn
	JPEmEmWR5KBoLMUkb7GJpXXr2WpJ/yBbdmNVC89RRsjlV6OIKHaqQOQO8DOagfVA/ID96S42yJQEK
	COv/MUwpKx8WGbf98tfFzidVpMtpo8cZT5cjO3vZzZ215aM5cIi7+rZNbDFNSJkkI0AE9SmWzBAAF
	oO8B8dXd/IW7Vb1XqDIZX4sGQfU5XL2ad/lxjpDoMsHMCHcfaQJg1abFy6LMI9SMHcBV3/K3aKIVf
	elDkpJIg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wFHbT-00000004sv7-1ZFx;
	Tue, 21 Apr 2026 20:21:51 +0000
Date: Tue, 21 Apr 2026 21:21:51 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: "Harry Yoo (Oracle)" <harry@kernel.org>
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
Message-ID: <20260421202151.GF3518998@ZenIV>
References: <20260416091022.36823-1-harry@kernel.org>
 <20260416091022.36823-3-harry@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260416091022.36823-3-harry@kernel.org>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Apr 16, 2026 at 06:10:16PM +0900, Harry Yoo (Oracle) wrote:
> When a file name length exceeds 31 (DCACHE_INLINE_LEN-1),

#ifdef CONFIG_64BIT
# define DNAME_INLINE_WORDS 5 /* 192 bytes */
#else
# ifdef CONFIG_SMP
#  define DNAME_INLINE_WORDS 9 /* 128 bytes */
# else
#  define DNAME_INLINE_WORDS 11 /* 128 bytes */
# endif
#endif

Where do you get that 31 from?
