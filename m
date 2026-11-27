Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795780402;
	b=t3zxBAPnXF9FjT+niL6BulFThFO4nk8PZWFQxcrDdfMTlDgc6bnI6tN4aYQcslSCWHuQ
	 pF/PpgENaNqASpDZZCmvWnqs/66+02tOLI4y5xklZlXOCbTqYNvRt7qnLE7rduthn8ukt
	 UOd9nvfzNTKq1dOL7aCqiRGh3ugIrmEILUWNe0UfVllBYTZVBFskgF0dYCcKEPhEpWZmE
	 iix5PFP7K6P2gVKeSELQ64pn4hWdTN9P2FeW4M1qLze1oLqpYy5F39ManAuMoIfqL+7TD
	 M15SkdCasyqSF0zjXIL2lSAOQSKdhMWNYUIzuGA1bV3oitoHpi4+H7f6GVnqcWBHS2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795780402;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=rByPEfNf4XLcPucHVrwkNxEV0dJQaoEcaC2v04KImDc=;
	b=pYKDC5pQr8yytRJx8PZFEri9Ub21bt8ie2DOyqDJND2TRReX7hbgSnNa3GT4uzYe3iai
	 bn/ltHCm74V4L2VCZduTEAVUuwQQtLNplmyzMqxdb/MDS0q4lsL0MQblXuItCbWnUMDvt
	 mCtcw0vPXMN5HbL43mA765gViRYC81msTvdAGn7DTB+F6rtbt3bTPkWYykIk//VujHGWk
	 mEwRU8imGW34ZBAc8akUnJ0I7B9T4oxtMOrQv9wLzHz6aJZjlYDynucXt8KGqXT4+iVK1
	 rA1kDt6/XeQnLH0uEZL2eEa4XFcTzuxHVegm9l4wyNEXEETPv4Hgt/1TYqdJrhaTnvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=itVam21t;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 7EFCF606A31C;
	Fri, 27 Nov 2026 11:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=itVam21t
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 8862A1F000C1;
	Fri, 27 Nov 2026 11:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795780402;
	bh=rByPEfNf4XLcPucHVrwkNxEV0dJQaoEcaC2v04KImDc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=itVam21tTHvEcaE5VJdWfQ/tgPSDAV6CDG2GMzdzyoN/mxuMlbjCKvTu2FworV8ko
	 U7OM/C/AREEZstZ1VU3BDDwN/goi5NSVpHgyhlDjXS6qgi2nf64jSnYSLll7UVpryS
	 WLdIPBh/exuiD/BBUBW5FXh68SNsHV4YssiLRrvITYGhcBKAd5wLXwjx7yGh5od1O1
	 8hMFBo2DQVo3yX8N1qNr+U/E5QyfOPsa03nsb5nl21/an5e2Oegt8L8t1cEqRNbZkM
	 efMDAmVRNTrhYS5cwidxYxi5Ge/AO1veZfDec67oehMQtdy9nU4FznwC7zn99d+vx+
	 UcvATeB77jmlA==
Date: Fri, 27 Nov 2026 13:53:18 +0200
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
Subject: Re: [PATCH v2] tpm: ibmvtpm: Fix unused suspend callback with
 CONFIG_PM_SLEEP=n
Message-ID: <awlvLjQT17DBZKpN@kernel.org>
References: <20261127051359.852628-1-zhouzhouyi@gmail.com>
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
In-Reply-To: <20261127051359.852628-1-zhouzhouyi@gmail.com>

On Fri, Nov 27, 2026 at 05:13:59AM +0000, Zhouyi Zhou wrote:
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
> Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
> ---
> Changes in v2:
> - Remove the blank line between Fixes: and Signed-off-by:.
> - Keep DEFINE_SIMPLE_DEV_PM_OPS() and its arguments on one line.
>   Both changes address Jarkko Sakkinen's review comments.
> 
> Only a targeted compile check was performed; the full RCU torture test
> was not run because it takes too long.
> 
>  drivers/char/tpm/tpm_ibmvtpm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_ibmvtpm.c b/drivers/char/tpm/tpm_ibmvtpm.c
> index 51c7e2add3d2..dd577f075c57 100644
> --- a/drivers/char/tpm/tpm_ibmvtpm.c
> +++ b/drivers/char/tpm/tpm_ibmvtpm.c
> @@ -462,7 +462,7 @@ static const struct tpm_class_ops tpm_ibmvtpm = {
>  	.req_canceled = tpm_ibmvtpm_req_canceled,
>  };
>  
> -static SIMPLE_DEV_PM_OPS(tpm_ibmvtpm_pm_ops, tpm_ibmvtpm_suspend, tpm_ibmvtpm_resume);
> +static DEFINE_SIMPLE_DEV_PM_OPS(tpm_ibmvtpm_pm_ops, tpm_ibmvtpm_suspend, tpm_ibmvtpm_resume);
>  
>  /**
>   * ibmvtpm_crq_get_next - Get next responded crq
> @@ -714,7 +714,7 @@ static struct vio_driver ibmvtpm_driver = {
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

Thanks.

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

Br, Jarkko
