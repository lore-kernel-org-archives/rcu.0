Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD141865A;
	Fri, 28 Jun 2024 11:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719573658; cv=none; b=QtDAokJbUkOzeAaSQaVTuTT+Rxb3ENKI5vh8kxngEULbjewk0xyYWxRf57fSixpjLEEMWed2ZuvoTQSAtDyx6806xFYN93pnm2WhgxokZsEwsRxvZ+u5HTBIdW4NpbM3lrxaGHYJSuxjnpgxC/TOymINuAyYM88+POQbpBfZscI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719573658; c=relaxed/simple;
	bh=gQeYH+LG8291IRJvEG/1gi0BWNeiPp2grvRZNYZzpOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ItDIYOMJra87GW4WRVzAWXl+nSw3e+962k53EbmR/TRoLaavYm+WwyMqNV8RJrrVzdUMl1YPpZOP4N5qcfvuvO2u4VlZMfde4P3JXl/eEXZS8XrBzZK/2w75vvbrhmcTCGkfjgFtdpmh/TQmY8fk/22ne7Za8DpAE0TnNrUklMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tR2BmwAe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tR2BmwAe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D509BC116B1;
	Fri, 28 Jun 2024 11:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719573658;
	bh=gQeYH+LG8291IRJvEG/1gi0BWNeiPp2grvRZNYZzpOs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tR2BmwAebw8/TRARIoz2TlXoGi4+WTnplk7PaCbcJOuu7t/Xl5eGVJgBTFl3xq2A4
	 9f/Hw5mPB1P2pNkTdjR27vTBdPH6pA35j2R/gSqo8KWMTREJb2vLxndLhIscjERriW
	 LtLPvECmB+RVriTMRBQDsHEjWDuqd1mksfUlw6/UFSu6HSn12qOgXy+DUl6w3qmpqb
	 4xSLzgZCr8rJ5q8adbSRQ7WX/UpK+xt0C9PgvnDhrTeVALat1KGv5l1gUCKKwGa5iF
	 6IEljwao4XARLmKWZ1Fp/fIut0MFe8mu5HUVU4fUgIZce+SK7DBiC97T4ulTaQ4gS0
	 ilErjw0iGoIfA==
Date: Fri, 28 Jun 2024 13:20:55 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org
Subject: Re: [PATCH rcu 3/6 v2] rcu/exp: Remove superfluous full memory
 barrier upon first EQS snapshot
Message-ID: <Zn6cl8PJWd8hWS_R@localhost.localdomain>
References: <81f4e616-8125-4934-a8e2-fd5beae90995@paulmck-laptop>
 <20240604222652.2370998-3-paulmck@kernel.org>
 <Zn1O2qKaIVOXniYH@pavilion.home>
 <4a11271a-d873-4f1c-87e6-38874e38ac13@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4a11271a-d873-4f1c-87e6-38874e38ac13@paulmck-laptop>

Le Thu, Jun 27, 2024 at 11:53:29AM -0700, Paul E. McKenney a écrit :
> On Thu, Jun 27, 2024 at 01:36:58PM +0200, Frederic Weisbecker wrote:
> > When the grace period kthread checks the extended quiescent state
> > counter of a CPU, full ordering is necessary to ensure that either:
> 
> Just to make sure that I understand...
> 
> I need to replace these commits in -rcu:
> 
> da979d0162fc6 rcu: Remove full ordering on second EQS snapshot
> 6411f4185f657 rcu: Remove superfluous full memory barrier upon first EQS snapshot
> dec56ca5f1c34 rcu/exp: Remove superfluous full memory barrier upon first EQS snapshot
> 
> With these three patches, and keep these three commits as they are?
> 
> d43a302fc08a5 rcu: Remove full memory barrier on boot time eqs sanity check
> b1c36aa90cbf1 rcu: Remove full memory barrier on RCU stall printout
> 64d68f1d53f77 rcu/exp: Remove redundant full memory barrier at the end of GP

Exactly! Those were the precisions I forgot to mention.

Thanks.
