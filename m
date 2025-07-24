Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896578F4A;
	Thu, 24 Jul 2025 05:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753334870; cv=none; b=ewn7Oq7U7clA7zIC0t2AAwXJVQJ8aX8t6OO+WraGK1FRMUN57VoSq05HHt8kaKWjV+KmzL1kbCD9utTdMWNgjXyXF1OGRpQdY2KFWSoJQ1IE63BQOxRMLWSrxjo4GvhYOx7+rTyQtayQxMrLnmjbR0ETFxYq5aDvDIl+MoLz05Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753334870; c=relaxed/simple;
	bh=nmw+e1nSY/Q+eQ8hPyS2qnwcN+bh6S6UuHHOkJBf2xI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q+z4O7VsJTr1b7UXLVyhm1ABURqE5nb6/j2hv3bP8mMr9bjb+izrVibwB97+F0aa0YP23/+EWFhABaiKsuZzJ7UZmJpUlXvYodqdDxUsxRjyD0F6lkHJpY/5MREuEXoSJIActPYliF1TDIMNXbPZMeMbmWc3n9xi4Tn7j8NND2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C00D2bss; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C00D2bss"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28CB1C4CEED;
	Thu, 24 Jul 2025 05:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753334870;
	bh=nmw+e1nSY/Q+eQ8hPyS2qnwcN+bh6S6UuHHOkJBf2xI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C00D2bssKPITaNtJ1UVM8Y357OnzvFJLrZpcrLKNLLB92JvfBmyPs5lkhp2Z9RY/k
	 XxLBmPHHJvSBxsMN8MahoCwvf7FlRGQqtHAaHTZqEUOvPjf87lj8zayTw6cbUmDYcC
	 KhYENGGfpP2zydDwc+IULYzIZ2APLHB8Rfh1hwSDLzGW924rQVWU1qzg8pWDkFU7Xn
	 zp6HXiNfVKU2vkHhemGtFPQDd+R1u6q6GHk4W/KM4P4Hd+k1tVBZmqxTDkBJT99nvu
	 2f+c34H6TJP8zZ0gyhNA6UfuEajlIfL6SdXWz1i4SsI2FxWfaM5IzlxIGB/BB7J+9z
	 nuFmbmC0Kjwmg==
Date: Thu, 24 Jul 2025 10:57:39 +0530
From: Neeraj Upadhyay <Neeraj.Upadhyay@kernel.org>
To: Tze-nan Wu =?utf-8?B?KOWQs+a+pOWNlyk=?= <Tze-nan.Wu@mediatek.com>
Cc: "frederic@kernel.org" <frederic@kernel.org>,
	"joelagnelf@nvidia.com" <joelagnelf@nvidia.com>,
	"jiangshanlai@gmail.com" <jiangshanlai@gmail.com>,
	Cheng-Jui Wang =?utf-8?B?KOeOi+ato+edvyk=?= <Cheng-Jui.Wang@mediatek.com>,
	"josh@joshtriplett.org" <josh@joshtriplett.org>,
	"boqun.feng@gmail.com" <boqun.feng@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>,
	Lorry Luo =?utf-8?B?KOe9l+ejiik=?= <Lorry.Luo@mediatek.com>,
	"weiyangyang@vivo.com" <weiyangyang@vivo.com>,
	Bobule Chang =?utf-8?B?KOW8teW8mOe+qSk=?= <bobule.chang@mediatek.com>,
	"urezki@gmail.com" <urezki@gmail.com>,
	"qiang.zhang@linux.dev" <qiang.zhang@linux.dev>,
	"neeraj.upadhyay@kernel.org" <neeraj.upadhyay@kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	wsd_upstream <wsd_upstream@mediatek.com>,
	"paulmck@kernel.org" <paulmck@kernel.org>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"rcu@vger.kernel.org" <rcu@vger.kernel.org>,
	"joel@joelfernandes.org" <joel@joelfernandes.org>
Subject: Re: [PATCH] rcu: Fix delayed execution of hurry callbacks
Message-ID: <20250724052739.GA15723@neeraj.linux>
References: <20250717055341.246468-1-Tze-nan.Wu@mediatek.com>
 <aHj79rtgLm-7tT9E@localhost.localdomain>
 <2c69ead1047ff7b7671b8b577fe69884870f66fd.camel@mediatek.com>
 <092ec583-9ad4-4d37-8dad-6008267a56a3@nvidia.com>
 <f7fce1ac56b908d49bf75359dd679d6664b648bf.camel@mediatek.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f7fce1ac56b908d49bf75359dd679d6664b648bf.camel@mediatek.com>

> > Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
> > 
> > I suggest let us add the Fixes tag too so that stable gets it.
> > 
> > thanks,
> > 
> >  - Joel
> > 
> 
> I noticed that I’ve already added the FIXES: tag, did you mean that we
> should also add this line "CC:stable@vger.kernel.org" ?
> 
> If that’s the case, should I submit a new version of this patch(V2)?
> 


Thanks Joel for reviewing the patch! I have already queued it for 6.17
[1]. So, v2 won't be required.


[1] https://git.kernel.org/pub/scm/linux/kernel/git/rcu/linux.git/log/?h=next


- Neeraj
