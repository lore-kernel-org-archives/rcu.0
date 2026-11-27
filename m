Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795754542;
	b=m7fD1HOzwebg1iGHWqZwHMfyXV+dSsC7IAvdCmkjtp7Dysg6+xm+YRzvik9Lf5BbSILd
	 0VKcPh1T9TOkGQ0tcN/SrQ3XfvlrIE1lxIQRk55P58tiijcUZ99OhcsaW4uLOLhVVwVFf
	 dfumcHVObfvVaLxLZ9R1tPvQt2/Tb3mhmwrgvT198sSIJ0bwn/WKJ1S0Al92ea6nUolrS
	 bIp4OeDkahN1CBRbRd/IRAZcURI0KrbpJ23cSegUZtPR3+b0/r4cg3QcrSNXaFgj49wfc
	 glczh4T5s3xLckfRRvo+U1KlWF7DfBoiXZW4IueYv+rkktEbx6lqKlTVl/99bHWTnrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795754542;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=2r21NtFZutp/tNeLCkdxw3coUtlf6pJI45+P6Sov/yw=;
	b=vUM4zg8IclXT3PBsZompqk3uJ7E2SZaflMz5Z3SzSDKP3ojpJuz8vDN7ob0fp57BUd3Y
	 FzWHk9/nexfd0uSbQxQ8VeJSR1BlYL2Umz4YpR8ELnxvDbmDBPqq5pW7dPEwM/AE7QNP1
	 SWa9W1gNQ2m5nuypMsd0tQdvIDHItJYDcJtqBWo5EdoQRcTbE+BkXqlBesAReb9oY/+Ls
	 0NEPbvgaZnG7QikVbO+Ujkw4wmvJts8Vt9GghhqlwXgUyWTPO3F5JgHQlKaUt1iFnmG8V
	 upJOtlDezRYSuBLFaUoT4+qS86k/AO3UF14wUXgloCW+xdfxJfJUNnreXQRIaQMBblw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cgkvq8fq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 29305606A682;
	Fri, 27 Nov 2026 04:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cgkvq8fq
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 467E11F00893;
	Fri, 27 Nov 2026 04:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795754541;
	bh=2r21NtFZutp/tNeLCkdxw3coUtlf6pJI45+P6Sov/yw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cgkvq8fqkP+xA1zj8/b/I1DdDLoXTTRaYx2FBzVV+laUoQ9f0ED2nub0ukGbKyWcf
	 HKe/241oXskPPGsjn2UdnmUJ7EEd34wJwCvpdczkuXEmGuTY3ggAg4V8gM764iXgkb
	 I0wBpAy1ubPW7VD7g8zvekIHWDgFA+7ah6nKOCFWlFiAOwrntc65iLUZ+ZPxS5WWeR
	 AzBIAvNEP526ONeFRTKeuC4dpqib1cwYeV9vQ9GHENszoNXTNdEFskaAqSZwWIJZmw
	 2Ue9Smr1mbBVwfV9/uiNk10dy4YUUcgCzKvryyzt7XdPMKCinH+rPQyjy5UujNS/5O
	 8+GUeKtk1Me/g==
Date: Fri, 27 Nov 2026 06:42:17 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Zhouyi Zhou <zhouzhouyi@gmail.com>
Cc: peterhuewe@gmx.de, lance@osuosl.org, rcu@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, linuxppc-dev@lists.ozlabs.org,
	linux-integrity@vger.kernel.org, Li Jun <lijun01@kylinos.cn>
Subject: Re: [PATCH] tpm: ibmvtpm: Fix unused suspend callback with
 CONFIG_PM_SLEEP=n
Message-ID: <awkKKfv4ZrVYy0Ky@kernel.org>
References: <20261127010124.848125-1-zhouzhouyi@gmail.com>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261127010124.848125-1-zhouzhouyi@gmail.com>

On Fri, Nov 27, 2026 at 01:01:24AM +0000, Zhouyi Zhou wrote:
> Discovered in the Open Source Lab of Oregon State University when running
> RCU torture.sh on a ppc64le VM.
> 
> With CONFIG_TCG_IBMVTPM=y and CONFIG_PM_SLEEP disabled, SIMPLE_DEV_PM_OPS()
> omits the references to the system sleep callbacks. This leaves
> tpm_ibmvtpm_suspend() unused and produces the following warning:
> 
>   warning: 'tpm_ibmvtpm_suspend' defined but not used [-Wunused-function]
> 
> Use DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr() so that the compiler
> sees the callback references and can discard the unused PM code when
> system sleep is disabled. Preserve tpm_ibmvtpm_resume(), which is also
> called directly from tpm_ibmvtpm_send().
> 
> Tested on PPC VM of the Open Source Lab
> of Oregon State University.
> 
> Fixes: fc0ddb3174b0 ("char: tpm: Use SIMPLE_DEV_PM_OPS for ibmvtpm power management")
> 

nit: should not have empty line here.

> Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
> ---
>  drivers/char/tpm/tpm_ibmvtpm.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_ibmvtpm.c b/drivers/char/tpm/tpm_ibmvtpm.c
> index 51c7e2add3d2..9840d0ebe6a3 100644
> --- a/drivers/char/tpm/tpm_ibmvtpm.c
> +++ b/drivers/char/tpm/tpm_ibmvtpm.c
> @@ -462,7 +462,8 @@ static const struct tpm_class_ops tpm_ibmvtpm = {
>  	.req_canceled = tpm_ibmvtpm_req_canceled,
>  };
>  
> -static SIMPLE_DEV_PM_OPS(tpm_ibmvtpm_pm_ops, tpm_ibmvtpm_suspend, tpm_ibmvtpm_resume);
> +static DEFINE_SIMPLE_DEV_PM_OPS(tpm_ibmvtpm_pm_ops,
> +				tpm_ibmvtpm_suspend, tpm_ibmvtpm_resume);

I'd keep these in same line.

>  
>  /**
>   * ibmvtpm_crq_get_next - Get next responded crq
> @@ -714,7 +715,7 @@ static struct vio_driver ibmvtpm_driver = {
>  	.remove		 = tpm_ibmvtpm_remove,
>  	.get_desired_dma = tpm_ibmvtpm_get_desired_dma,
>  	.name		 = tpm_ibmvtpm_driver_name,
> -	.pm		 = &tpm_ibmvtpm_pm_ops,
> +	.pm		 = pm_sleep_ptr(&tpm_ibmvtpm_pm_ops),
>  };
>  
>  /**
> 
> base-commit: 5f22fb20497f4983094131f00a734362300d22d2

Otherwise, it's good.

Br, Jarkko
