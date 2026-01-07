Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6063469EE;
	Wed,  7 Jan 2026 17:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767807100; cv=none; b=cqFE7RR/r/h8p/FqZayVgpwiR1o+YoPbnXtzmFc7Y7CgpIufeEr1zrZBXeKK2m+WbFreFzfYhH3q9BlwZHXd8QxhP+xKUWu809auLZNnr9WEUnhXKScYxJ/XgLC3B5un9L8XI8ikusWd6ERGotevCp73bh/cZrXbqoJ0BhTbjxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767807100; c=relaxed/simple;
	bh=WHzqbWsrcmv4udy6c/npiPHkKzdKMcKcwo3VtJCvGLA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lxQ3L59RD++zZnzh5ot9FgFZ89M1rvEPdO6KZIzbEUkT0CkYYEb7eXNJnVkh2B2djzTsR9lLrexEhbq2EKPd+VoRaiMJqZ7HKFYNNhByA9N9yiYaTdWEDvG9YndWIW2lcPo1+vG7Mb/mU3Jb8K+Czl48GcIHpzPnYoVLxxsHKh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf06.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id 9F99A16048D;
	Wed,  7 Jan 2026 17:31:35 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf06.hostedemail.com (Postfix) with ESMTPA id D68202000F;
	Wed,  7 Jan 2026 17:31:32 +0000 (UTC)
Date: Wed, 7 Jan 2026 12:31:59 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Joel Fernandes
 <joel@joelfernandes.org>, John Hubbard <jhubbard@nvidia.com>,
 linux-kernel@vger.kernel.org, rcu@vger.kernel.org, rust-for-linux
 <rust-for-linux@vger.kernel.org>, nouveau@lists.freedesktop.org, Boqun Feng
 <boqun.feng@gmail.com>, Paul E McKenney <paulmck@kernel.org>, Jason
 Gunthorpe <jgg@nvidia.com>, rostedt@google.com, Yury Norov
 <yury.norov@gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Update email address for Joel Fernandes
Message-ID: <20260107123159.7ac61d69@gandalf.local.home>
In-Reply-To: <39e74621-aba6-47eb-9935-0d2321c56d6d@nvidia.com>
References: <c5c5c0a4-249f-41b0-b5f1-87a58514b120@nvidia.com>
	<8822A0A5-CD4C-403A-A001-F4E7A351D81B@joelfernandes.org>
	<CANiq72mUCGL3f=GAYSZfMV1=NXpOjz4vsV7B3Pd-=EG8tmWC_A@mail.gmail.com>
	<39e74621-aba6-47eb-9935-0d2321c56d6d@nvidia.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: D68202000F
X-Stat-Signature: iz1q955ux1j95575p3magymhwn1ocpdi
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/BB/wLHRPf79Wd6nZwG8A6By8H7RvT6cw=
X-HE-Tag: 1767807092-95633
X-HE-Meta: U2FsdGVkX1+WGcNYiwZhZJzaeKHl+I/r5SspS9IyQbARG1Ivwm13yowxselsSjVF1Nn2WbQp8NrBzBz4vy2LctgZSMu+a4znAhiCXz0AKC3yNYbhLTTwOnJaBueduDzy6aKIXFkIJ9erK+Id0qWtwl9zlhindJFd+tElJLcugVwqcLZSkOxQUdnrzMasvZ57+vRakddUBF0B0cN1Nfe0SyYF6mXo0doBr8NJK9xzsx1TyLtf1GhygtV/zfBN+WgFlFtWSIr99x34PM4wJjlk/VgfEeIVC4TQhCfZUyw1U1ns1WjO1KOdOobqaavkLIFWGn/0XkhoRmPeYpqxDhevljJEwCmlGEN4oBgzE9vP2ucD7y9Qc3kIskoGh2H4up3D9P3PyRFM/HlGdWWd/tqV6t5RsPfwJtzQO9z3Jyhum0E=

On Wed, 7 Jan 2026 12:20:42 -0500
Joel Fernandes <joelagnelf@nvidia.com> wrote:

> Thank you for the suggestion! Unfortunately, that would hide the company
> attribution too. Or require it to be in brackets along with the name. There
> appears to be resistance to both these. I do feel fortunate to get company time
> to work upstream, so, on this matter, I have to go with the company's
> preferences.;-). There also appears to be significant progress now to resolve
> the email issues which looks promising (thanks Jason, John and everyone for the
> efforts!).

The one issue I have with people using (or being forced to use) their work
email address is that people switch companies all the time. I find it very
annoying when Cc's suddenly get bounced because it is going to the old
company email address. Worse yet when the developer is still involved with
the upstream community and now they are simply not getting email that they
should be.

This is why I prefer the "(company)" in the email name and not the address.
It allows developers to maintain the same email while they move companies.
I did this for Red Hat, VMware and now Google, and all with the same email
address.

Although I may need to switch to my kernel.org address because my
goodmis.org is being blocked by gmail :-p

> 
> Happy New Year! Thanks,

Happy New Year to you Joel!

-- Steve
