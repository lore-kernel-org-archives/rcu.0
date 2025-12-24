Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736671DEFE9;
	Wed, 24 Dec 2025 14:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766585586; cv=none; b=rbR65A+T6dtUpDm9/+Ig8/FoRQxSJfRpBhpZ7zkQ3Jtz8xqdCI2elvz5YO/xeWv20myqxpyebJpPNRpEDEbqn33/8YMKVTkz/E3cjdR8qUu7prwrE8pB/FGFIdSFIroe3sPpGmmcZSClNEHwIC1ttp/VyDmAIwAJUBANKKG7tdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766585586; c=relaxed/simple;
	bh=FPCYK1WaiScECwb83p5J5fMHtgU2nv0JwGAqb5OLx4E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kMhR7hB0KZY61pcP8NEEMp3i1Kr4ivdVYtcV6NpHuMnPhgumhuhK/IQ0eBx7x70QUC50IELTX06vsWlzzVhf7zqDrFQwQxI2+aclbI7/WK43EnW0ILGm0mayBg/yQHOmN0Nb1xIwXeXVJz9DhNLFIawPXwS0W9gFwX1YC5cElSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf19.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id F0890160249;
	Wed, 24 Dec 2025 14:13:00 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf19.hostedemail.com (Postfix) with ESMTPA id 3092520025;
	Wed, 24 Dec 2025 14:12:58 +0000 (UTC)
Date: Wed, 24 Dec 2025 09:14:50 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Joel Fernandes <joelagnelf@nvidia.com>, linux-kernel@vger.kernel.org,
 Davidlohr Bueso <dave@stgolabs.net>, Josh Triplett <josh@joshtriplett.org>,
 Frederic Weisbecker <frederic@kernel.org>, Neeraj Upadhyay
 <neeraj.upadhyay@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Uladzislau
 Rezki <urezki@gmail.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>,
 Zqiang <qiang.zhang@linux.dev>, rcu@vger.kernel.org, clm@meta.com
Subject: Re: [PATCH] rcutorture: Fix operator precedence bug in
 exp_current() invocation
Message-ID: <20251224091450.6ef76142@gandalf.local.home>
In-Reply-To: <511ba78b-06f9-4f4e-b27b-e83428d81217@paulmck-laptop>
References: <20251223004407.61147-1-joelagnelf@nvidia.com>
	<4bbae00e-f078-4f1e-a1e0-b1cdc72981de@paulmck-laptop>
	<20251223113758.2c6bb15d@gandalf.local.home>
	<f99bbb2e-62bd-47fb-8cee-07716766c087@nvidia.com>
	<52bda0a7-5311-4e62-89c5-287c731548e4@paulmck-laptop>
	<086174f6-8bc9-4417-a878-ef665c0b0f10@nvidia.com>
	<fa889e55-19f6-417b-9a25-676ecfcd39a7@paulmck-laptop>
	<20251223155443.7165adf9@gandalf.local.home>
	<511ba78b-06f9-4f4e-b27b-e83428d81217@paulmck-laptop>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: bgncyc4m36iyid3a9cosnfw536cdmz7j
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 3092520025
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+8QYi6z/OANHLGMu4Mg8TpNxcCEe3mkQw=
X-HE-Tag: 1766585578-351638
X-HE-Meta: U2FsdGVkX1+n8PhOtkjUb6OEswZ/W9oiAwuH0OUClBTDIAgx/kMcUm1j5lxKe1bWEqSN1XYBB7xGUWKMojlqwhTwIRLS8k/RqosSOSXhwgZfVNhKF+KYgOckB05RJ10PU3Yc3ur7HkmK33Ao5eZyFsNc/CcNJODF2SalIQJfRif61LoA06MEdVcT+3aybf2zjEhZbcKDbWWFqmWk2UIjGTaGYP5g3G7U3AGPf4v35NLD13/AVbgP7G/ds5m+kgP0MYGNDtsmAQqnjoz15rEW123+oP7NhYbI7zUoEETxi6My+cZafXOLAI5cJmgufymPiO2Yg7UC/al4HsfEV0X1A7NcivtiUHTp

On Tue, 23 Dec 2025 15:50:18 -0800
"Paul E. McKenney" <paulmck@kernel.org> wrote:

> Does that mean that my intelligence is artificial?
> 
> Choose your answer carefully.  But don't worry about my reaction to it.
> After all, more than six decades of being incessantly targeted by
> advertising has made me quite good at ignoring things.  ;-)

Paul, I don't think your intelligence is artificial. Heck I usually tell
people the two most intelligent kernel developers are you and Al Viro.

Although, maybe all intelligence is artificial? Who knows?

-- Steve
