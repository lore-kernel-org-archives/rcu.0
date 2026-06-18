Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A2C1CAA6C;
	Thu, 18 Jun 2026 04:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781755281; cv=none; b=YKIV4DP3VHC3K5rGgNEW3riRR1qey6VSBDgQyEkeVwMoQ0I6TLDDoaD13C6NbbVnw8pznui3hFB5YXvT8eTIvRJeAa7DKs8MAHgwujf+UjfDpn9vzSGt0UaE96W8e91XB6Ay7AOq499fnulwML4wMfUkM9kUSnZiki+gKk0a0VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781755281; c=relaxed/simple;
	bh=OTnUmKoK9XYBD7fNsWMwSFxgF8DlWQEC8y4QAp6L6eY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r2vhwmQCkJS8NF1BY5tITtCRh4nxsDDVRidpitZJf6tMwjrZiWjsOxnYRSC1jyOoUn2ZrxNLQH5AT1aNwSyUtFn19UjR+j+artOFA4NBWuVlY94pRbrMcGcICKFKZYRD+rf0qgZHYiHjfR9edAKcii9Uin/AVnvlm7LZz4V/2Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D8vnH9U6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D8vnH9U6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44C731F000E9;
	Thu, 18 Jun 2026 04:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781755280;
	bh=kYQzEH0PhFDdh4xuYwzEjUe8I+5bm2oe/jWI0W05JVQ=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=D8vnH9U63WFzmvkNWTPTdlmyCn5ama+IJRztaOOeBD3hTZGBpHHZgPWITZbVjVP9C
	 MvzMn6889mBVD+qjst7w0sG3/U20db3zcQnKxG9TYqNkIKM/SSzgCSL6FpdrKi5Oiu
	 7L9HB5WvNuhq0LcCYiIiCUxOiYNB53ZjH0a+vlPdXcEZ+Z9DFXr8q8QxV7/uKo387E
	 4QKguWpEl2R7gP5un79TQimXgcZ6dHujqqHY8DcknyasgfVDsWToMDHm4gx9Fa5wY0
	 LfkWnKm843LmTLtwx5esPwb2Vl6hGHG5fOe5/X9k+XngC4QrLjbthRWcW6wtz9yPZU
	 HkloLgoeLhgwQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 04A3ECE0845; Wed, 17 Jun 2026 21:01:20 -0700 (PDT)
Date: Wed, 17 Jun 2026 21:01:19 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Alan Stern <stern@rowland.harvard.edu>,
	Usama Arif <usama.arif@linux.dev>, lkmm@lists.linux.dev,
	joelagnelf@nvidia.com, linux-kernel@vger.kernel.org,
	marco.crivellari@suse.com, rafael.j.wysocki@intel.com,
	riel@surriel.com, sshegde@linux.ibm.com, tglx@kernel.org,
	ulfh@kernel.org, yury.norov@gmail.com, rcu@vger.kernel.org,
	shakeel.butt@linux.dev, hannes@cmpxchg.org, kernel-team@meta.com
Subject: Re: [PATCH] smp: Use release stores for csd_lock_record() state
Message-ID: <1250b28d-484d-459a-bad8-bba6e8116ed5@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260617212001.3658605-1-usama.arif@linux.dev>
 <831f9fb1-82a5-46ba-9541-b82c94e43639@rowland.harvard.edu>
 <2d4034d5-fa7c-463b-89c3-2725e4dbd137@infradead.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d4034d5-fa7c-463b-89c3-2725e4dbd137@infradead.org>

On Wed, Jun 17, 2026 at 08:30:32PM -0700, Randy Dunlap wrote:
> 
> 
> On 6/17/26 6:44 PM, Alan Stern wrote:
> > On Wed, Jun 17, 2026 at 02:20:01PM -0700, Usama Arif wrote:
> >> __csd_lock_record() publishes per-CPU CSD debug state that is read by
> >> csd_lock_wait_toolong() on another CPU.  The remote side first reads
> >> cur_csd with smp_load_acquire() and, when non-NULL, may then read the
> >> matching cur_csd_func and cur_csd_info fields.
> >>
> >> Use smp_store_release() when publishing cur_csd so that the preceding
> >> cur_csd_func and cur_csd_info stores are ordered before the pointer
> >> that csd_lock_wait_toolong() acquires.  This replaces the open-coded
> >> smp_wmb() plus plain cur_csd store with the release operation that
> >> matches the smp_load_acquire() in csd_lock_wait_toolong().
> >>
> >> For the clear path, use smp_store_release(&cur_csd, NULL) so that
> >> clearing the diagnostic state remains ordered after the preceding
> >> callback/unlock work, without requiring a full barrier before the
> >> store.  On x86 this removes the locked full barrier from the clear
> >> path; on weaker memory models it uses the release operation needed by
> >> the smp_load_acquire() in csd_lock_wait_toolong().
> >>
> >> The old code also had smp_mb() calls around cur_csd updates. Those would
> >> only be needed if cur_csd were treated as an exact live-state marker whose
> >> publication had to be observed before callback execution or CSD unlock.
> >> CSD stall warnings do not currently have RCU-style stall-ended checks, so
> >> they already allow the stall to end while diagnostics are being assembled.
> >> The cur_csd record is therefore best-effort diagnostic context, not a
> >> precise completion/stall boundary.
> >>
> >> Signed-off-by: Usama Arif <usama.arif@linux.dev>
> >> ---
> >>  kernel/smp.c | 8 ++------
> >>  1 file changed, 2 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/kernel/smp.c b/kernel/smp.c
> >> index a0bb56bd8dda..5ba4a20ba77d 100644
> >> --- a/kernel/smp.c
> >> +++ b/kernel/smp.c
> >> @@ -182,16 +182,12 @@ static atomic_t csd_bug_count = ATOMIC_INIT(0);
> >>  static void __csd_lock_record(call_single_data_t *csd)
> >>  {
> >>  	if (!csd) {
> >> -		smp_mb(); /* NULL cur_csd after unlock. */
> >> -		__this_cpu_write(cur_csd, NULL);
> >> +		smp_store_release(this_cpu_ptr(&cur_csd), NULL);
> >>  		return;
> >>  	}
> >>  	__this_cpu_write(cur_csd_func, csd->func);
> >>  	__this_cpu_write(cur_csd_info, csd->info);
> >> -	smp_wmb(); /* func and info before csd. */
> >> -	__this_cpu_write(cur_csd, csd);
> >> -	smp_mb(); /* Update cur_csd before function call. */
> >> -		  /* Or before unlock, as the case may be. */
> >> +	smp_store_release(this_cpu_ptr(&cur_csd), csd);
> > 
> > Isn't there a general policy in the kernel that memory barriers should 
> > be accompanied by a comment explaining what other memory barriers they 
> > synchronize with?  Including such comments is a good idea in any case.
> 
> in Documentation/process/submit-checklist.rst:
> 
> 3) All memory barriers {e.g., ``barrier()``, ``rmb()``, ``wmb()``} need a
>    comment in the source code that explains the logic of what they are doing
>    and why.
> 
> in Documentation/process/4.Coding.rst:
> 
> Certain things should always be commented.  Uses of memory barriers should
> be accompanied by a line explaining why the barrier is necessary.
> 
> but looking in the 3000+ lines of Documentation/memory-barriers.txt won't tell
> anyone about that.

Is smp_store_release() a memory barrier?  Sorry, couldn't resist... ;-)

							Thanx, Paul
