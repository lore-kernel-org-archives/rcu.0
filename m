Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01FB79CD;
	Tue, 23 Dec 2025 16:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766507790; cv=none; b=kWskQBhjmkj3o9HKYymYhsiYuAAJp1DsjNwKgUVIz2FoRnw8L3VRZxmQ/iN+CxFJortj6iIIu+IluK3XFagdNIPShS0BAr5n9mlWWUN01kecRokllceuU51JqlGiSKusY6dbFd0ITBb3YWilyEXxjv/N28u+CvXS6MMbDMuNMjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766507790; c=relaxed/simple;
	bh=oA8XLav7MB4ZNjijhgikz7vPxZyx4IxguQEOblcXWYw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fM+sUTUti4p8RHnlBATyQCMkIfRM19jMAhLIb2+RlrcbV+Z1cxkOy5btpipoVwhzv4d0/rwYPGIzS69NBnxfXEIw3PcoP1dp+oWe7wvxEJ+WAbrdCli0XDKtRDOsM0YrqzNm74ImoqY5xlwSoYTHUOgfxx/umR/HsilavpK2L94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf15.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id 250391402A3;
	Tue, 23 Dec 2025 16:36:20 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf15.hostedemail.com (Postfix) with ESMTPA id 9559018;
	Tue, 23 Dec 2025 16:36:17 +0000 (UTC)
Date: Tue, 23 Dec 2025 11:37:58 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Joel Fernandes <joelagnelf@nvidia.com>, linux-kernel@vger.kernel.org,
 Davidlohr Bueso <dave@stgolabs.net>, Josh Triplett <josh@joshtriplett.org>,
 Frederic Weisbecker <frederic@kernel.org>, Neeraj Upadhyay
 <neeraj.upadhyay@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Uladzislau
 Rezki <urezki@gmail.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>,
 Zqiang <qiang.zhang@linux.dev>, rcu@vger.kernel.org
Subject: Re: [PATCH] rcutorture: Fix operator precedence bug in
 exp_current() invocation
Message-ID: <20251223113758.2c6bb15d@gandalf.local.home>
In-Reply-To: <4bbae00e-f078-4f1e-a1e0-b1cdc72981de@paulmck-laptop>
References: <20251223004407.61147-1-joelagnelf@nvidia.com>
	<4bbae00e-f078-4f1e-a1e0-b1cdc72981de@paulmck-laptop>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 73a13dqx61tysjr8qxjoss83r7uy3a3a
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: 9559018
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19MKW712Y/a+SmU5FS9X/VdDK9IU4/t+vs=
X-HE-Tag: 1766507777-799515
X-HE-Meta: U2FsdGVkX18Y942k9scuPlkBnxj3rTpj+xY7zkrCDNJbQ0YmHonlfbtCJ07dwzDZr877b5pTuHam9pT6lgN4qlK4oL6yhpZLZ7NyyxPkIcLe9IqPhFsjzo8x4ku3zzN2MVwU7QYKMbDRNHp/fvQ93hs5LkzhTNSVH57JwPRwrMq2S2Bu/OePKHJQeV2Inw5PqtXxxRYpvr+UULbxUI8K62gmCrf/GRKBt1VWFIZrsqirvd7jKyJfqgo92D3syloszbVGfa51bZoI2ZjHiiL6ypd1gHHInfnQRhsWpYuGHXtabLWcr8IIJfR37BCAV5B+tgf43kt1vSLKqtMOyOlP960DEHnlU8tDWUKBBPSBfQ84KcndliTlUQ==

On Mon, 22 Dec 2025 17:12:18 -0800
"Paul E. McKenney" <paulmck@kernel.org> wrote:

> Good eyes, thank you!
> 
> Unfortunately, Chris Mason beat you to it:

Was it Chris or his AI? ;-)

-- Steve
