Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8445D4C62;
	Wed,  2 Jul 2025 11:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751454693; cv=none; b=O7iF8e8A3eFUgd33GYVHCvCbmweD7OoyTwq/ntRRDnJIhwKRULTpDdMPVY9Ll19lFO45ughR03Bb7Qxee8RHEXjeJ8uP9ssIilJvHCHxh88ZZqRsS7Nx02J83XBo/sR9shmVMtRz/UDSsgJMS4UsEu/Mf0mHJaRFdQBC7v4RpDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751454693; c=relaxed/simple;
	bh=a+vFWdK2Bu0il04uJBl9lLaE09MP8HIkf+V0dwPCQa4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rEhTIIrRRhXr95DX/Vxjlgh6SQxaR+E1n6WMVaNZoAhbuYAC4mzTm5iEHufeGox6c+F2YU1eTluaiZRm/iWjcOL5VV1uTZYgGK1XdpM9z3nOnHEXywk4ORs/ath9YNOpNsGPF5H/yNg+jesca6l7S3JyCasTD4q+lmgBbrI0kqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RMaJhbbu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RMaJhbbu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DD93C4CEED;
	Wed,  2 Jul 2025 11:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751454693;
	bh=a+vFWdK2Bu0il04uJBl9lLaE09MP8HIkf+V0dwPCQa4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RMaJhbbuM+14scJcn9PUy5jrz9q2+6jMWFTQwZ2Yxp2/G1oV/GhBetNsu1FRzkOex
	 5J1H/vHHULtWwYK1wUTBC2AyIrMNPFuSVS01jaSa0mI2CmolOTXEOvRF5iBcGtzHAT
	 NM24UeUx2Q8rKo2RxTTYdS09FSs5uZ728nei00kuXO07GJtLQLN7wVbg7KANaZvha0
	 uIdMWnEhuQIx8HQ/Ljoeio4dRTvaWII/6PueR4uUh86h7gAE4r7JuDoL/JuHdx/z+T
	 ULximuZxudW7l9cAD7upv/wtu3LciRdxiXHzXYS5hU27whdgz812WkT1W3Tf1rD/dy
	 zUOYeWZ2b0a8Q==
Date: Wed, 2 Jul 2025 13:11:30 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: Qi Xi <xiqi2@huawei.com>, paulmck@kernel.org,
	Xiongfeng Wang <wangxiongfeng2@huawei.com>,
	Joel Fernandes <joel@joelfernandes.org>, ankur.a.arora@oracle.com,
	Boqun Feng <boqun.feng@gmail.com>, neeraj.upadhyay@kernel.org,
	urezki@gmail.com, rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Wangshaobo (bobo)" <bobo.shaobowang@huawei.com>,
	Xie XiuQi <xiexiuqi@huawei.com>
Subject: Re: [QUESTION] problems report: rcu_read_unlock_special() called in
 irq_exit() causes dead loop
Message-ID: <aGUT4sCXE_56Wsv-@localhost.localdomain>
References: <20250603185939.GA1109523@joelnvbox>
 <066e8121-c6c5-48ac-b35a-e6430d986dff@nvidia.com>
 <a82784fd-d51e-4ea2-9d5c-43db971a3074@nvidia.com>
 <c448118b-9f7e-4c29-d6b3-a66e70f7163f@huawei.com>
 <a963b475-72cd-474d-96d4-9e651fc8f857@paulmck-laptop>
 <e7354668-2573-4564-834b-44d76d983222@nvidia.com>
 <09e4d018-3db4-404e-a8f0-041cdee15a62@huawei.com>
 <279d2f06-d4f7-46e1-9678-999a2d19b710@nvidia.com>
 <506d8c4e-c317-4c85-9bcf-695596551d28@huawei.com>
 <166bc5aa-a715-438e-8805-c74c2b5fc83b@nvidia.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <166bc5aa-a715-438e-8805-c74c2b5fc83b@nvidia.com>

Le Wed, Jul 02, 2025 at 06:59:38AM -0400, Joel Fernandes a écrit :
> 
> 
> On 7/2/2025 5:14 AM, Qi Xi wrote:
> > Hi Joel,
> > 
> > After applying the 2 patches, the problem still exists. Compared to the previous
> > fixes which did solve the problem, the difference is ct_in_irq() in the first
> > patch.
> > 
> > I am wondering why "nesting != CT_NESTING_IRQ_NONIDLE" is added?
> > 
> > 
> > (previous fix: problem is solved)
> > 
> > +bool ct_in_irq(void)
> > +{
> > +    return ct_nmi_nesting() != 0;
> > +}
> > 
> > (current fix: problem still exists)
> > 
> > +bool ct_in_irq(void)
> > +{
> > +    long nesting = ct_nmi_nesting();
> > +
> > +    return (nesting && nesting != CT_NESTING_IRQ_NONIDLE);
> > +}
> 
> Oh gosh, thanks for spotting that! Indeed,  I had changed it to != 0 in the last
> version but applied an older patch. I will fix it in the tree. Thank you again!
> 
> Neeraj, would you like this as a separate commit that you can then squash? Or
> could you fix it up in your tree?

nesting == CT_NESTING_IRQ_NONIDLE means that the rcu_is_watching() and we are
not in an interrupt. We still need to rule out that case, right?

Is there something else that makes it not working?

-- 
Frederic Weisbecker
SUSE Labs
