Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0680033FD;
	Fri,  9 May 2025 13:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746797613; cv=none; b=MozN+r1lGZyYFw6LH7Ypehs3aUypcTez3BenyeH4RCgts+bFWUOuE0icBcNegD4H0x9m9DXohsO61byKsk7IYvIYb9uZ/UB6mtBsXkByQM4EpeBlS4UY7z+3zR+T1tdJZ10reTCvvfcxr6Q/b9XQZdTSdlQeET/4+m5bM9FAVlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746797613; c=relaxed/simple;
	bh=vUkjVmgHbl5bkGxqT1facucSdubrZByHBHyHxJ0RHyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NuZPug+a3NQC6FO25R7EEtYc3wAM2n6lsMm9mSjOSuDBEMWht6DQK7j5QlY9SBFlKUFrV6nYIuOWGsgHhsjbSlf40z+cl4yzX4mQ1hAEJk3UF3Vdoc+eq7GLqs8zRsZdYyVJG6n8YJdiH76+5IT3Hdg/At29yYQasbSjXbA2iy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lHEsOSV2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lHEsOSV2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC0D6C4CEE4;
	Fri,  9 May 2025 13:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746797612;
	bh=vUkjVmgHbl5bkGxqT1facucSdubrZByHBHyHxJ0RHyU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lHEsOSV2142oH3KJyOD6L6m7K1/ingI/kY7z75SaCl/Y2bI5tmRpzKbmaDTW01JNa
	 7gLVLpeLO4aB3Xzj8+PmhxMEFtgM366xxi5wHyhmrET6F2jVbon3b32leiDpJW77EP
	 Q+CtfqiglJ2XAw+RdgU9IGQhCH4lHq7kE17RBkqYhT1y/UTEff8PPDuwg4tW9DRYaY
	 mNicjLac0wbE4t5xtSfljeK14T0eDxJwkGOi94M5v8NjZbQdic/mjU6SnfVXYQLxaD
	 2h/AO3O+uZHoKQS+ZFbAM5eSubCmubhRETkViEvycD9pbglMDpS6kEQf1AngaraaDi
	 yEOm3n8Oybp4g==
Date: Fri, 9 May 2025 15:33:29 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Z qiang <qiang.zhang1211@gmail.com>
Cc: paulmck@kernel.org, neeraj.upadhyay@kernel.org, joel@joelfernandes.org,
	urezki@gmail.com, boqun.feng@gmail.com, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] rcu/nocb: Add Safe checks for access offloaded rdp
Message-ID: <aB4EKfvicJ558J7A@localhost.localdomain>
References: <20250507112605.20910-1-qiang.zhang1211@gmail.com>
 <20250507112605.20910-2-qiang.zhang1211@gmail.com>
 <aBuJi3jhcp4dCbSY@localhost.localdomain>
 <CALm+0cWyWrEcsYx+6nDT9XjMdLBDwx27SmAXTPUFLB59TbEc3Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALm+0cWyWrEcsYx+6nDT9XjMdLBDwx27SmAXTPUFLB59TbEc3Q@mail.gmail.com>

Le Thu, May 08, 2025 at 02:43:11PM +0800, Z qiang a écrit :
> On Thu, May 8, 2025 at 12:25 AM Frederic Weisbecker <frederic@kernel.org> wrote:
> > On a second thought, isn't "rdp == this_cpu_ptr(&rcu_data)" enough?
> 
> If the CONFIG_DEBUG_PREEMPT=y, the following code will cause
> a warning in rcuop kthreads:
> 
> WARN_ON_ONCE(!rcu_rdp_is_offloaded(rdp))

I keep forgetting that, indeed!

Looks good then, thanks.

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

-- 
Frederic Weisbecker
SUSE Labs
