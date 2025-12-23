Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012027.outbound.protection.outlook.com [40.93.195.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153D42E2DEF;
	Tue, 23 Dec 2025 17:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766510577; cv=fail; b=RGLkrTcJ8UapEPlKq/gwUQ1uuz+WyBnFNNcQ44avoP0tXIX7YPyH3zBXJJ2truFNxSR2iVJKH/bVO50f8O5DitZ49CDQ/5bmDY/Mp7CDppY8Cikno5kqx6aQaANZsjsSN9LIVAhUqp2/b95BMHzpE0bknk8IrFgbKXkdsdaVgKA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766510577; c=relaxed/simple;
	bh=x0q9fp2uMSLn0DQDQ9Urw0ExCHgHKNKJkstXX2ButUI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nKn4OUIzivMsr5Ye/lhXk/pO+QJgXqXLUU+aq6y2FzhHElWsPdyu5aRPHNKLlk3TEvdZOpgfT8tRIwNEBXPa9h0+l8oElo8x4/xxEPQO1VW0fqxEpNz/VUaXaxxJp2egHkyzQ3Xv5XImOGPboxHooken0vooeHvb3E6arnG0SpQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=stFz2YAj; arc=fail smtp.client-ip=40.93.195.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="stFz2YAj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VyJ0dy3VMbrq4qPK4+B3ilXbv9Nf/W3sG03lWJhsTLzeWyUm/+5FbOHKX/K+x3DNZ2sZmjF3H3daZ1urOZBCj4d+BRtkV8y7ZYzj/GiLJSTwhz2wYfJ9vcipi6/lEP+ILAhemoWlfmgaAykuDAlxe5zMllI6x694oyA+a+1FcostCcrtd2g93qE2RMfla9zTOvmY70DOm9pA6voTv/Au2Jk4qft5x/izdyqF7uCJog2QIWna7JtXF4lryWL741bGb7rjDpBlN0Ex910Mzy72fUpsde5NATOcUQEdES/iHvxjOBanLNdEL0EzGT8Gg0R1UCrtw+2s6zgG/Pz6iOK1AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=08aCjw3mwvgxkCeN9goih4dDl4Ht96DFZ5GbsNwzAHI=;
 b=gl+K9nQAE6SeYpoJ4oaRZlC1HfDhoOVKsO8+rjJq93qpMNe1p0MZGa1etLU/o1WrwmqxZJNWl5A/bnrCmDkkSZ1/BoZHqNXYH76eFmUHCF0L5ehXhYmdEdB8ZaqosxU+GT+QA5fsFoKftwe73mXgUMdfCvRQq4Qlyb+EGGtnRropoN9b2fxaeChnv5BPBKZN+Tw/QSIOajdTGpOmsVqJvgMiKYlW/ECeSzXmuOyBiYR6kHZOFAa+lAhYZ9Rw90bLlo4j2hDHiTHOjfsGdEm5yc16PC8hnDfa03BvY/ilcsWtA9q9he30H93tpUTeRllZ0coPudeHRJ1HpdL8+Kpyfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=08aCjw3mwvgxkCeN9goih4dDl4Ht96DFZ5GbsNwzAHI=;
 b=stFz2YAjcCekE33YI2B9D1QSVIGAAMyVLEff8GSwOPF4bbez+zI/lbFJK8WVwLM5x7aS03Ze6GVOmsY3OMJjl1ULbkrJ4Y4kEheXo/Ks67ZmVOm5j6Hp1I2PvNZOWy/RxMK1O8ncNyEv0kksCxP3EY9yeKdVAGuTnfR2eFFItdB1MYNj174+sf/+XhdY+Ebd6KnPGCRISEAzcWLmvJDLzns7+VPd0H9G7NIJGTe0HF9lhdyQxA54Vq9RWK8PN1+yhX9CfCfFzdSlImkRlhY6BBfvdVwazKKvG2fR2wB1IOnRMySEbnODTGjqec9Gka5vDDtSdOZHBMyo4X7CobNlAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by SN7PR12MB7177.namprd12.prod.outlook.com (2603:10b6:806:2a5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.11; Tue, 23 Dec
 2025 17:22:53 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%2]) with mapi id 15.20.9434.009; Tue, 23 Dec 2025
 17:22:53 +0000
Message-ID: <f99bbb2e-62bd-47fb-8cee-07716766c087@nvidia.com>
Date: Tue, 23 Dec 2025 12:22:51 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rcutorture: Fix operator precedence bug in exp_current()
 invocation
To: Steven Rostedt <rostedt@goodmis.org>,
 "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
 Josh Triplett <josh@joshtriplett.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>, Uladzislau Rezki <urezki@gmail.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>,
 rcu@vger.kernel.org
References: <20251223004407.61147-1-joelagnelf@nvidia.com>
 <4bbae00e-f078-4f1e-a1e0-b1cdc72981de@paulmck-laptop>
 <20251223113758.2c6bb15d@gandalf.local.home>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <20251223113758.2c6bb15d@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0246.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::11) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|SN7PR12MB7177:EE_
X-MS-Office365-Filtering-Correlation-Id: bccb7c0d-67d4-4e89-4547-08de4247e799
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dGpwaXN3bVc4TmVQTnVWNVpPN09meFFlY1crNHVRSTVhT3A3US85bXRDMktC?=
 =?utf-8?B?NkRiWHduQjRLWjB3bUJCZm1NbzNGdnlsRUpCZ0trRXRFTWt0SG0vcHhYbVNK?=
 =?utf-8?B?QUNJZ1V3QkVGWXBhWTA5a3BQY2ZYWXVDeEplNkY2MFNvWm9sTndXd1VNUmQ0?=
 =?utf-8?B?L1dLT0VTOFJ5L1h1ZEgwMTJUSkJ6V0RLeDJLZlJWZG9IZGVqVCtoazc5eWxk?=
 =?utf-8?B?UkUraWVhQXNTWE9XZUtLVE5BNkpqcG5Lc2MzWlZXWmJtQ09tRjVVMWI1L3NS?=
 =?utf-8?B?M2dLcnVzb0VtcDhPUlIvb0pRaWJoVXZFcURZL2wybWVnSDM2YkJ4R3VpeGM1?=
 =?utf-8?B?WlpNRGxEL3dKa3lVc3BHa1ZvWVhUVzd3dVlHODg5RGYwODVWdHVtMkxpUGl5?=
 =?utf-8?B?TExzQm0rU2N2WDVMUmkzZ210bVh5b1ZKOVJBcldkSEdxcUhydDNXdWlaRGpp?=
 =?utf-8?B?bFhvc0pPdEk5TGpUU1JFVHc0QVo1WjVIRS83MU00eG11bm5PTXZ5QmhBY2ZF?=
 =?utf-8?B?UlVuK3M0djkwMUVnWU5mU0MyaThkQVZGU1ZzUjYyaEdBL1UzVmFWc2p6VXhr?=
 =?utf-8?B?N2tTbmRRUSttU2tsbXMxT3JMRDRDNHlnQStBcTZaTVNDTUZycWtYaTdGMW9x?=
 =?utf-8?B?MVF2d2lBVksveEtlb1FlUzhESWxmdEtzSzVjcGYzcWVDZUQ1SGdRSjFKTkYz?=
 =?utf-8?B?SkJvLzE5WURyK1JSa083ZHo5YWxhWGFXVWxYM2s5RlprSjZWVUFjRGJ6Mi9v?=
 =?utf-8?B?Zzg0bUJUWlJ6dndRbVFFakF0cUdPNHFCN1VLWUFqWStyVDQ0ZktoejRYajB5?=
 =?utf-8?B?MndKSlBvUDBhbGxBWXdYT211UURMRTEzZ2R5ckR6YmMxbVpoc3N6akNZd2ZF?=
 =?utf-8?B?OTNwTkhlQUxxdTV1a2JLdjlZUUlUTXY3b1QveURQckJpNThOaTc5enhOUHMr?=
 =?utf-8?B?NmdyUzQ0dk1vWFNTUmFRaWYzUlVBRG9HUjNHck1wa2hWMUEwR1lwblNDL0Y3?=
 =?utf-8?B?WjczUG03enZQM3BLSFdIMUt2VUVJV3BzS3FZVWdGTXlkK0hQUDMzRXp3anFN?=
 =?utf-8?B?SzBIem5QMGdvSFVXc3RpMU5LQ1I5SWt1T2trTjhqV0Z1UGNXTG9oa3VObnZp?=
 =?utf-8?B?aUxIK3hUR2lYNDlzeHZISVp1QXBUeDJjSEJCUlg5Y2hPUFBOWmFYN3dGcjhF?=
 =?utf-8?B?Wk80T0hzZ1dyaTV4SS9qWW9zMGJnTkY4TGUxcWlGT1pUZENPdjJmeGtvVVlU?=
 =?utf-8?B?TmRseDlPUmJXTllkRUw5UWdlQUhtQnVDekNsS05wS2ZxZUJnTjBSQkNZMXNz?=
 =?utf-8?B?REE4dFN5dWRLQVkwMy9jMFk1SmlsZjRZRFU1eWN4eVhvUE1tSWl1Q1FHRFk2?=
 =?utf-8?B?WW1xRERxNFFQa1Z5OE1pbUMveFE0dE4xNUY0MmMyU2RFc1JEd01ocnE1bnd0?=
 =?utf-8?B?TkhrVE8zQlp1VjUvZ2JucTliUDdZVTlzcHhoUG1XZENMcGNKQ3YwOEFKV1lH?=
 =?utf-8?B?eDdob096enU5UlpKRTl6L25XZ1lnb3lyVWpmcDVkLzdwRzRTbm9qRFNhUjlt?=
 =?utf-8?B?RVhQa3pwQXdwV1QwT3ZLY0VIbzdDZXFlUWNBR0Z3eWZrTGsxNmNJUmlIWlpu?=
 =?utf-8?B?aG5ORmlTT0pCbmQreGZRL2RxcDIyVmFTK0RRcVpQbFJYUGI1T2tEQ0M4OWhs?=
 =?utf-8?B?RE1uYU43ZWkyb0pocWRqQjB6elZjcGtxYkI0SUhLcWwvL1c2WVZ4T2l0bDQ3?=
 =?utf-8?B?amQ4NlFNcUVaVkk5OXJsQms1a21GZnpVenZIeTBvYmNXSnpCM3g0NW5xcUNs?=
 =?utf-8?B?SWh4RzVteXo4bE40Wmw3dzJCdnlUbksweGk3K1ZGM2hSZXBDMkRvWnVSSGIv?=
 =?utf-8?B?YjNEdU9UZEc2NjFVR3dtaCtGUHM1ZDNPSkNyd00rZ3BUcDlhQUw2bVlHbERu?=
 =?utf-8?Q?mJySI64hQshq28DJz0JBXr+Wmcxp8vyM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NmtzNE0wQStzdWFnbGJ5aTBhS3QwekNOcXMvZDhsR0t1N0NXczBwaTllQjEv?=
 =?utf-8?B?TkVjZzFiSis5NWFiNXZPaVFGWnRWd3FBWm9MS2U1UkgzcWVoenBDRWFOcnhz?=
 =?utf-8?B?a0wwTHk0a1lPSjlrQS9WSzEyeWUzYkplbGZmV2x1WERSdUVRK0xOaE1TVDdC?=
 =?utf-8?B?UE5VZFZTWWp6bnhNYnpRZkxsbVNrRWdWYnZmK1pWZm5wU3BRZS9mSzRNNVd1?=
 =?utf-8?B?WEYwbmRna0tuY3BZMlJNN2pJMnBNLzZieU9OSURXNDdmZzFwSnI5Y3N5b2J6?=
 =?utf-8?B?TVRIMHZpYVc4Y2tyRnRPT2pPbVFOVEZIb0FCdGQxZGlNU1BKWGh1a1lHR3ZZ?=
 =?utf-8?B?RUJPNllBT0NhRHk1UnQ1K2NEcDQ4M0pUejdvUlVMRHNGdnNaZ3RLQmthVSsy?=
 =?utf-8?B?eGxUVkRyS2pxdGJvUWp1bEtxclZMRWxwVjRHVnZ3aVNKRFZlUjUyZi91aVBC?=
 =?utf-8?B?S3lYU1ZQNFJlYmNORXl6TStSMGtoWWN2c0J0bFo1QVNrMTVYcEJMUnVjeDU4?=
 =?utf-8?B?VGQzQ0lIN3E5TGJGWmh1cFI5VkxxcjRzOGErc2g3cThKYytuN0dGMVRnTW12?=
 =?utf-8?B?UUF0T0ZHdURZTi94QWVPSVZvWnN5VjB0QmRhN0Y2Z1M5OTAxajcvZXVYb29H?=
 =?utf-8?B?Y3ltRnh6MEpIREdmd2RYWlZmcHlueFF5L1Z1NHFYbG0zY0VBcWwzUUxpcklN?=
 =?utf-8?B?TDdJT2h6elZaYjhURlp5SXdJNlZ5UTVscUhya1ZiSEVhb0FUSXRRckoyMk16?=
 =?utf-8?B?L2dxNnAxU3FvYVBMMHZFWFNpTHdpYlBGTHZxbmQ3UmJrblpjQ0N3TlJQZEVo?=
 =?utf-8?B?RnNZNmxYTkVlRWNuak8xMG93VGxsQVZDTkpRcXpRZE5tMmpyb3Y0L0U5Y0FD?=
 =?utf-8?B?U1p5ZXRhaERtbzYreWJIemh3V3grMTFocnUyZlBsT1YrZXhOZ2ZTV0NtNG1J?=
 =?utf-8?B?T2RyRi8rYWZXSDNyM3RMNXhKMzl0RkN3TnBoZkRJSWlXb2hSVkkxd1dETUx1?=
 =?utf-8?B?QUNzc1NwSi8vOTl0U2ZpSGZjdVl0Y2JCNk1HK3NaZGxLTmdWb0JyZU1NdDUr?=
 =?utf-8?B?M015N0xtS3hQSklONzFQVlZtVEdWOFFuUjhJZ3NjaGFBZ09lQUQ5QTgzR1VW?=
 =?utf-8?B?Ung2Q3R6elBCOFR4N0N3YnBWclk3ZnV3RXM1NTJKRkh6aTllWlVWcG45MTdJ?=
 =?utf-8?B?V3N4b1Q4TVk1akJVd0hqcmtiam1QUkIwcHlwUVNveGhpL0pmazBqRHUzQ0lN?=
 =?utf-8?B?dElEekhXd1VaR3h4OXpWR1VjeUlMWTU3Vkdhdk0vQjIvT2k4dytUdjZlc1ZZ?=
 =?utf-8?B?enhNSnpoeVkvYmxOZnEwaUh3cktZK1RaN01lYVFod2RGNURvWVpmTlpPNjhM?=
 =?utf-8?B?YldSa05sMjB2OHZYTVRjajBKSWk3VDZBRXNmNEZWdEFaTFAvTk5CWVQ4OXF0?=
 =?utf-8?B?cmJLSHNxTzJGKzNDZTVJaE5CZncyNFlnYlVwYXIxZDUwMmhYZytZRjFodXht?=
 =?utf-8?B?SHNOVzRmQUZPZFduTUJpMEMxL0VNS0h0L1dxREZFcDEwSU5KUlBqbFpRMk42?=
 =?utf-8?B?cW9ML2t1QS9QVGI0TnIwaCtYWjFzcXU0N04zZ3JKYVdyamFxMlpxTGswNHpE?=
 =?utf-8?B?ZUNNREhwd056V0pqeXNzalBpQ2VKWFZFeWEwbzBiTnZaOEJvVGl0c2sxTVJp?=
 =?utf-8?B?ZUNnWFZKc3ZRejNXZWVHNHdKbkVxN2pMdVQ5Mm42TUlsZ3JHanVIblQ5dXVP?=
 =?utf-8?B?QUVwQVlmUi9MY29tcWVXWXphb09WUm9qbjhHM2c5eHMxRGljVmlsMjJpbEdP?=
 =?utf-8?B?d2wvK3BiL3VNd1RaU1lzamh3bXhKT29kTTVVbzlnQW1ra3A1U2VFZk5tUFJX?=
 =?utf-8?B?V3N5UmpoRFR2RG90aU9RaDMwREdLc2xrRjZWcURWck5OYmY2T2I4R1VzODl3?=
 =?utf-8?B?aVZRU0JabE9zdzh5RVhkOHljc0FBNnpWaHdHcENvam1Wd0UxTXBDUUo5RjNp?=
 =?utf-8?B?K2xPLytPNStIYVVvL2x1MjkvdUlub1lta2lHSG9RVnkvRENiY2tGTXpXZFk3?=
 =?utf-8?B?L2l2S1VnYVpXczVSeTcxSTlQTDYwOXE4dlNqY1JCUlVINUUxcXViMDlQYjln?=
 =?utf-8?B?OEFjMGtiRmRMMjdrcDg3L1JkNkNUT2xiYUIzRk9ZOG1wSTBOdkpCSDRNbEpK?=
 =?utf-8?B?SExyMlhVZXArVDBzOWl5RDI4QWdiMDlWNlFmaDFvWW93dWdXNTdHSjdlczdD?=
 =?utf-8?B?YzczRUxuMWZSL2t3c0U2bndXL212ckhoQ1VwTyt4dTZZeU1WMkoybGVZRzVU?=
 =?utf-8?B?Q3owckFCTUJ4TTdqbmZySG9haGhzNWxlc2JTK0lJWlRxWkZyK0Rsdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bccb7c0d-67d4-4e89-4547-08de4247e799
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2025 17:22:52.9898
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F6G4Bf18yZVRw9rtRVbkDCRjMEWkb0kIzOo7ewHhxW86B24rVl7k/AfNQIel+pCtJOyv5zsVbp+R0q275Fewwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7177

On 12/23/2025 11:37 AM, Steven Rostedt wrote:
> On Mon, 22 Dec 2025 17:12:18 -0800
> "Paul E. McKenney" <paulmck@kernel.org> wrote:
> 
>> Good eyes, thank you!
>>
>> Unfortunately, Chris Mason beat you to it:
> 
> Was it Chris or his AI? ;-)

Does it matter? It is like saying, was it "Chris or his text editor". ;-)

 - Joel

