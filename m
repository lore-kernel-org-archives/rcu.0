Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B0451C29
	for <rcu@vger.kernel.org>; Mon, 29 Jan 2024 22:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706568192; cv=none; b=tL27PT5RFjEz+a/JD+FZhkUArNjfixDQkWpKvPgRaQvxdhozbO89vTWH7Sylwoe2pbKl/3YiBQTRiuYKxQl7rscAxNWGPmcvbWI/HOmVwLXE4q6NtnUZ+ic5f/CzpfJc45qx1oVr1RsXvDSwA5EO3D/8Z8lgrUOBHmpBAoHfSDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706568192; c=relaxed/simple;
	bh=lhzKE9PIB50Uk1j1xVuaMM80GoQOH/ogGcMPAt7V4s0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KIQgH9b3CGNa2aQZLbFsYWtjf+U0bCcIel59uaE8Oi4DrKq8zYrVsTkTfe0CrisooTdKOGH4FRQWsI1RP94XJHP0j3jVTV0M86/D4xNXkpwHjYykjuUSpl8SyAXNrXnPDNvvWcE1WaihQ3CrMqwWghl6JPMndVJxsW8u4UJDfEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ThFijngW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ThFijngW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83CD8C433F1;
	Mon, 29 Jan 2024 22:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706568192;
	bh=lhzKE9PIB50Uk1j1xVuaMM80GoQOH/ogGcMPAt7V4s0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ThFijngWQkRdyzPxbWMMWaZ5bRZeFxNRdr7reSNlWXLBLDGTrdsXdJGe0UsZeWQO2
	 /QgkhkGBrZTEP32MvdRacwL6bQlc4F24wzm39bc0zNWa8WI7RPl+XnFz761zQarIDJ
	 AbY7WaP1YquoR2iyaLPferxM2mAEO1mklY2QbhSJ/qpeDOjnsTYxACyyjptY5Tfuk2
	 x65nVLS0gUu7oie+aYAHOevwnKcIbxdOH74LdBMmAxSpO45qsouncGATzwYhQQboBV
	 W1YjLDq9P8EVCd/hna8OnaLTKx6wUMYYSuYBB4RuM79nXkyiUmu+O3g4iugoEp7UIR
	 O1kA3NcYDqFKw==
Date: Mon, 29 Jan 2024 23:43:08 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Joel Fernandes <joel@joelfernandes.org>
Cc: Uladzislau Rezki <urezki@gmail.com>, Joel Fernandes <joelaf@google.com>,
	rcu@vger.kernel.org, "Cc: Frederic Weisbecker" <fweisbec@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: Observation on NOHZ_FULL
Message-ID: <Zbgp_JJvdczGccV3@pavilion.home>
References: <CAJWu+oo8w6zc=m7f9vkz66xYZnoCqs1FrgmLtcWxEpE5QCJgig@mail.gmail.com>
 <ZbgPL0Rg_on4kOBf@pc636>
 <b6672b7b-fed4-449b-90e5-216f8294c1c3@joelfernandes.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b6672b7b-fed4-449b-90e5-216f8294c1c3@joelfernandes.org>

Le Mon, Jan 29, 2024 at 05:20:23PM -0500, Joel Fernandes a écrit :
> > If i do not miss something
> > the NO_HZ_FULL will disable the timer if there is only one task on CPU
> > so that running task benefits from not being interrupted thus gets more
> > CPU time.
> 
> Yes, that's right. I believe it is well known that HPC-type of workloads benefit
> from FULL, however it has led to want to try it out for constrained system as
> well where CPU cycles are a premium, especially if the improvement is like what
> the report suggests (give or take the concerns/questions Paul raised).

I'll be unable to suggest anything related to that Bogomips calculation but
I must add something about HPC.

I have long believed that HPC would benefit from nohz_full but I actually never
heard of any user of that. The current known users of nohz_full are workloads
that don't use the kernel once the application is launched and do their own
stack of, for example, networking, talking directly to the device from
userspace. Using DPDK for example. These usecases are for extremely low latency
expectations (a single interrupt can make you lose).

HPC looks to me different, making use of syscalls and kernel for I/O. Nohz_full
may remove timer IRQs but it adds performance loss on kernel entry, making it
probably unsuitable there. But I might be wrong.

Thanks.

> 
> Thanks,
> 
>  - Joel
> 
